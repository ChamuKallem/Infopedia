# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create!(
  email: 'admin@example.com',
  password: 'adminpw',
  role: 0
)
admin.skip_confirmation!
admin.save!

3.times do
  User.create!(
  email: Faker::Internet.email,
  password: Faker::Internet.password,
  role: Faker::Number.between(0, 2)
  )
end
users = User.all
5.times do
  Wiki.create!(
    title: Faker::Book.title,
    body: Faker::Lorem.paragraph,
    private: Faker::Boolean.boolean,
    user_id: users.sample.id
  )
end

# Wiki.create!(
#   title: "Dogs",
#   body: "Dogs are the most faithful creatures on this planet",
#   private: false,
#   user_id: users.sample.id)
#
# Wiki.create!(
#   title: "Cats",
#   body: "Cats are very simple",
#   private: false,
#   user_id: users.sample.id)
#
# Wiki.create!(
#   title: "Bugs",
#   body: "Bugs are the most creepy yet useful creatures",
#   private: false,
#   user_id: users.sample.id)

wikis = Wiki.all

puts "Seed finished"
puts "#{User.count} users were created"
puts "#{Wiki.count} wikis are created"
