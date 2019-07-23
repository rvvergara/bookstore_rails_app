class CollectionItem < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :current_page, presence: true
  validates :book_id,
            uniqueness: { scope: :user_id,
                          message: 'can only be added once in collection' }
  
  default_scope { order(created_at: :desc).eager_load(:user) }

  def data
    book.data_hash.merge(
      included: true,
      item_id: id,
      current_page: current_page
    )
  end
end
