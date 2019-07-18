class CollectionItem < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :current_page, presence: true
  validates :book_id, 
            uniqueness: { scope: :user_id,
                          message: "can only be added once in collection"
                        } 
end
