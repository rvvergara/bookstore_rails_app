class CollectionItem < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :current_page, presence: true
end
