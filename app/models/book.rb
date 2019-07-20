class Book < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_term, against: [:title, :subtitle, :authors, :description, :category, :isbn],
    using: {
      tsearch: {
        any_word: true,
        prefix: true
      }
    }

  default_scope { order(:created_at).eager_load(:items)}
  validates :title,
            :subtitle,
            :authors,
            :description,
            :category,
            :published_date,
            :page_count,
            :thumbnail,
            :isbn,
            presence: true

  has_many :items, class_name: "CollectionItem", foreign_key: :book_id
  
  def self.user_book_search(user, keyword)
    initial_set = Book.search_by_term(keyword)
    # Return an array of book hashes that includes
    # data on whether a book is in a user's collection
    initial_set.map do |book|
      included = !user.items.where("book_id=?", book.id).empty?
      item_id = included ? user.items.where("book_id=?", book.id).first.id : nil
      book.book_data[:included] = included
      book.book_data[:item_id] = item_id
      book_data
    end
  end
end
