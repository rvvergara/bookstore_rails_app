class Category < ApplicationRecord
  default_scope { order(:created_at)}
  validates :name, presence: true, uniqueness: true
end
