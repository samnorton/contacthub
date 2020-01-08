# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.destroy_all
Contact.destroy_all

category_ids = []

category_ids << Category.create(name: "Family").id 
category_ids << Category.create(name: "Work").id 
category_ids << Category.create(name: "Church").id 

p "#{category_ids.count} categories created."

categories_count = category_ids.length

contacts = []

number_of_contacts = 20

number_of_contacts.times do |i|
  new_contact = {
      name: Faker::Name.name,
      email: Faker::Internet.email,
      mobile: Faker::PhoneNumber.cell_phone,
      phone: Faker::PhoneNumber.phone_number,
      country: Faker::Address.country,
      address: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state,
      zip: Faker::Address.zip,
      note: Faker::Quote.matz,
      category_id: category_ids[Random.rand(0...categories_count)]
  }

  contacts.push(new_contact);
end

Contact.create(contacts)

p "#{number_of_contacts} contacts created."