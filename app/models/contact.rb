class Contact < ApplicationRecord
  belongs_to :category
  has_one_attached :contact_avatar

  validates :name, :email, presence: true
  validates_length_of :name, minimum: 3
  validates_length_of :mobile, minimum: 7, maximum: 15, allow_blank: true
  validates_length_of :phone, minimum: 7, maximum: 15, allow_blank: true

  # def self.search(term)
  #   if term && term.empty?
  #     where('name LIKE ?', "%#{term}%")
  #   else 
  #     all
  #   end
  # end

  scope :search, -> (term) do
    where('LOWER(name) LIKE :term or LOWER(email) LIKE :term or LOWER(country) LIKE :term', term: "%#{term}%")
  end

  # scope :seach, -> (term) {  where('name LIKE ?', "%#{term}%") if term && !term.empty? }

  # scope :search, -> (term) {  where('name LIKE ?', "%#{term}%") if term.present? }

   
end
