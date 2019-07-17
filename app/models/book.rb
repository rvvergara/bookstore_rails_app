class Book < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_term, against: [:title, :subtitle, :authors, :description, :category, :isbn],
    using: {
      tsearch: {
        any_word: true,
        prefix: true
      }
    }

  default_scope { order(:created_at)}
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

end
