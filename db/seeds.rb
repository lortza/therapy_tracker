puts 'Destroying all assets'
# User.destroy_all
LogEntry.destroy_all

puts 'Building Users'
# User.create!(first_name: 'Admin', last_name: 'McAdmins', email: 'admin@example.com', admin: true, password: 'password', password_confirmation: 'password')
# User.create!(first_name: 'User1First', last_name: 'User1Last', email: 'user1@example.com', admin: false, password: 'password', password_confirmation: 'password')

puts 'Building Logs'
LogEntry.create!([
  { sets: 3, reps: 10, exercise_name: "clam shells", datetime_exercised: 'Sat, 23 Mar 2019 19:29:00 UTC +00:00', current_pain_level: 2, current_pain_frequency: "nearly constant", progress_note: "hip generally feels more supported, but pain is still very present"},
  { sets: 3, reps: 10, exercise_name: "clam shells", datetime_exercised: 'Sun, 24 Mar 2019 09:30:00 UTC +00:00', current_pain_level: 2, current_pain_frequency: "only when provoked", progress_note: "feeling good this morning. hip cracked during exercise and that felt nice."}
])
