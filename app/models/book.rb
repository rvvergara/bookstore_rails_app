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

    initial_set.map do |book|
      included = !user.items.where("book_id=?", book.id).empty?
      {
      id: book.id,
      title: book.title,
      subtitle: book.subtitle,
      authors: book.authors,
      category: book.category,
      description: book.description,
      published_date: book.published_date,
      isbn: book.isbn,
      page_count: book.page_count,
      thumbnail: book.thumbnail,
      included: included
      }
    end
  end
end
