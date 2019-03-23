puts 'Destroying all assets'
User.destroy_all

puts 'Building Users'
User.create!(first_name: 'Admin', last_name: 'McAdmins', email: 'admin@example.com', admin: true, password: 'password', password_confirmation: 'password')
User.create!(first_name: 'User1First', last_name: 'User1Last', email: 'user1@example.com', admin: false, password: 'password', password_confirmation: 'password')
