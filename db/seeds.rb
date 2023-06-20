# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
first_user = User.create(
  name: 'Fatima',
  photo: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThmoTXZ0E6e4_trAN2Hd4jncffUKxehrw6RY-RYt_u&s',
  bio: 'Teacher from Mexico.',
  email: 'akandeabdul@gmail.com',
  password: 'Ameerah@2020'
)

puts first_user.errors.full_messages unless first_user.persisted?