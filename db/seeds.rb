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
#
# messages = [
#   'That is a good question, let me find out for you',
#   'I am going to connect you with Steeve from the shipping department. He will be able to'\
#       ' help ypu with this problem',
#   'Would you mind holding on for a few minutes while I am checking this with our administrator?',
#   'I am sorry, we made a mistake and sent the invoice to the wrong email address, which is'\
#       ' why you did not receive it.',
#   'We do not have this feature at moment. We do intend to add it to our service and we can'\
#       ' notify you when is has been done.',
#   'We are finxing this now and hope to have everything ready for you by tomorrow. We will '\
#       'keep you posted.',
#   'Let me put you on hold for just a few moments and verify this information.',
#   'I need to review your transaction history. Please bear with me for a few more minutes.',
#   'We would not be the right company to help you with your question'
# ]
# people = User.all
# people.each do |user|
#   messages.each do |message|
#     user.create(message)
#   end
# end