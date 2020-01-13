class Category < ApplicationRecord
    has_many :contacts

    validates :name, uniqueness: true
end
