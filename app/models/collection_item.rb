class CollectionItem < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :current_page, presence: true
  validates :book_id, 
            uniqueness: { scope: :user_id,
                          message: "can only be added once in collection"
                        } 

  def book_data
    {
      book_id: book.id,
      title: book.title,
      subtitle: book.subtitle,
      authors: book.authors,
      category: book.category,
      description: book.description,
      published_date: book.published_date,
      isbn: book.isbn,
      page_count: book.page_count,
      current_page: current_page
    }
  end
end
