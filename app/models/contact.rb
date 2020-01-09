class Contact < ApplicationRecord
  belongs_to :category
  has_one_attached :contact_avatar

  validates :name, :email, :mobile, :phone, :country, :address, :city, :state, :zip, presence: true
  validates_length_of :name, minimum: 3
  validates_length_of :mobile, minimum: 7, maximum: 15
  validates_length_of :phone, minimum: 7, maximum: 15
  validates_length_of :zip, minimum: 4, maximum: 12
end
