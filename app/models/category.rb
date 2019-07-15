class Category < ApplicationRecord
  default_scope { order(:created_at)}
  validates :name, presence: true, uniqueness: true

  has_many :books, foreign_key: :category_id
end
