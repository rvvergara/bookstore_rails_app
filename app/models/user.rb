class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  before_save :username_downcase!

  validates :username, :first_name, :last_name, presence: true
  validates :username, uniqueness: true

  default_scope { order(:created_at)}

  has_many :items, class_name: "CollectionItem", foreign_key: :user_id, dependent: :destroy
  
  def collection
    items.all.map do |item|
      book = item.book
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
        current_page: item.current_page
      }
    end
  end

  private

  def username_downcase!
    username.downcase!
  end
end
