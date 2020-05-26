# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u1 = User.new(email: 'shubham@gmail.com', name: 'Shubham', password: '123456', password_confirmation: '123456')
image = 'https://www.gravatar.com/avatar/' + Digest::MD5.hexdigest(u1.email)
u1.gravatar_url = image
u1.save

u1 = User.new(email: 'lmaldonadoch@gmail.com', name: 'Luis', password: '123456', password_confirmation: '123456')
image = 'https://www.gravatar.com/avatar/' + Digest::MD5.hexdigest(u1.email)
u1.gravatar_url = image
u1.save

u1 = User.new(email: 'wendy@gmail.com', name: 'Wendy', password: '123456', password_confirmation: '123456')
image = 'https://www.gravatar.com/avatar/' + Digest::MD5.hexdigest(u1.email)
u1.gravatar_url = image
u1.save

u1 = User.new(email: 'carlos@gmail.com', name: 'Carlos', password: '123456', password_confirmation: '123456')
image = 'https://www.gravatar.com/avatar/' + Digest::MD5.hexdigest(u1.email)
u1.gravatar_url = image
u1.save

u1 = User.new(email: 'adele@gmail.com', name: 'Adele', password: '123456', password_confirmation: '123456')
image = 'https://www.gravatar.com/avatar/' + Digest::MD5.hexdigest(u1.email)
u1.gravatar_url = image
u1.save