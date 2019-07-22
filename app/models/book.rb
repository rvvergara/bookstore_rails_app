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
  

  def data_hash
    {
      id: id,
      title: title,
      subtitle: subtitle,
      authors: authors,
      category: category,
      description: description,
      published_date: published_date,
      isbn: isbn,
      page_count: page_count,
      thumbnail: thumbnail,
    }
  end

  def self.user_book_search(user, keyword)
    initial_set = Book.search_by_term(keyword)
    initial_set.map do |book|
      included = !user.items.where("book_id=?", book.id).empty?
      item_id = included ? user.items.where("book_id=?", book.id).first.id : nil
      book.data_hash.merge(included: included, item_id: item_id)
    end
  end
end
