class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  before_save :username_downcase!

  validates :username, :first_name, :last_name, presence: true
  validates :username, uniqueness: true

  def username_downcase!
    username.downcase!
  end
end
