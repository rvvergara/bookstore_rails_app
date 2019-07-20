class CollectionItem < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :current_page, presence: true
  validates :book_id, 
            uniqueness: { scope: :user_id,
                          message: "can only be added once in collection"
                        }
  
                        default_scope { order(created_at: :desc).eager_load(:user)}

  def book_data
    {
      id: id,
      book_id: book.id,
      title: book.title,
      subtitle: book.subtitle,
      authors: book.authors,
      category: book.category,
      description: book.description,
      published_date: book.published_date,
      isbn: book.isbn,
      page_count: book.page_count,
      thumbnail: book.thumbnail,
      current_page: current_page
    }
  end
end
