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
      item.book.data_hash.merge(included: true, id: item.id, current_page: item.current_page)
    end
  end

  private

  def username_downcase!
    username.downcase!
  end
end
