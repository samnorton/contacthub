# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Contact.destroy_all
Category.destroy_all
User.destroy_all

user_ids = []

user_ids << User.create(name: 'Nick Carter', email: 'nickcarter@gmail.com', password: 'grace0512').id
user_ids << User.create(name: 'Joel Thomson', email: 'joelthomson@gmail.com', password: 'grace0512').id

p "2 users created."

category_ids = { user_ids[0] => [], user_ids[1] => [] }

category_ids[user_ids[0]] << Category.create(name: "Family", user_id: user_ids[0]).id 
category_ids[user_ids[0]] << Category.create(name: "Work", user_id: user_ids[0]).id 
category_ids[user_ids[1]]<< Category.create(name: "Church", user_id: user_ids[1]).id 
category_ids[user_ids[1]]<< Category.create(name: "Friends", user_id: user_ids[1]).id 

p "#{category_ids.count} categories created."

categories_count = category_ids.length

contacts = []

100.times do |i|
  user_id = user_ids[Random.rand(0...2)]

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
      category_id: category_ids[user_id][Random.rand(0...categories_count)],
      user_id: user_id
  }

  contacts.push(new_contact);
end

Contact.create(contacts)

p "#{Contact.count} contacts created."