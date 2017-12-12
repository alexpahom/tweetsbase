# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Users (username, first name, last name, email, phone)
[
  %w(Captain Steeve Rojers captaina@mar.com 111-222-333),
  %w(Hulk Bruce Benner bennerb@mar.com 111-222-111),
  %w(Iron Tony Stark starkt@ind.com 37533-304-33),
  %w(EagleEye Clint Barton bartonc@mar.com 37533-550-23),
  %w(Widow Natasha Romanova romann@mar.com 37529-302-33),
  %w(Spider Peter Parker net@mar.com 37525-223-23)
].each do |user, first, last, mail, phone_number|
  user = User.create(
    username: user,
    first_name: first,
    last_name: last,
    email: mail,
    phone: phone_number
  )
end
