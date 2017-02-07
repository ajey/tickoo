# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create! name: 'John Doe', email: 'john@gmail.com', role: 'customer', password: 'topsecret', password_confirmation: 'topsecret'
user = User.create! name: 'Jane Doe', email: 'jane@gmail.com', role: 'customer', password: 'topsecret', password_confirmation: 'topsecret'
user = User.create! name: '007', email: '007@gmail.com', role: 'agent', password: 'topsecret', password_confirmation: 'topsecret'
user = User.create! name: '006', email: '006@gmail.com', role: 'agent', password: 'topsecret', password_confirmation: 'topsecret'
user = User.create! name: 'tickoo', email: 'tickoo@gmail.com', role: 'admin', password: 'topsecret', password_confirmation: 'topsecret'
