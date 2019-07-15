class Book < ApplicationRecord
  default_scope { order(:created_at)}
  belongs_to :category
  validates :title,
            :subtitle,
            :authors,
            :description,
            :published_date,
            :page_count,
            :thumbnail,
            :isbn,
            presence: true
end
