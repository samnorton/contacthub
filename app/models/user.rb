class User < ApplicationRecord
  has_many :contacts, dependent: :delete_all
  has_many :categories, dependent: :delete_all
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :user_avatar
end
