# frozen_string_literal: true

#-------------------------------------------
#             DELETE ALL SEEDS
#-------------------------------------------
puts "Destroying all assets"
ExerciseLog.destroy_all
PainLog.destroy_all
PtSessionLog.destroy_all
SlitLog.destroy_all
Pain.destroy_all
BodyPart.destroy_all
Exercise.destroy_all
User.destroy_all

#-------------------------------------------
#            CREATE USER
#-------------------------------------------
puts "Seeding Users"
existing_user = User.find_by(email: "admin@email.com", admin: true)
user = existing_user.present? ? existing_user : FactoryBot.create(:user, email: "admin@email.com", admin: true)

#-------------------------------------------
#            BUILD BASE CLASSES
#-------------------------------------------
puts "Seeding Exercises"
FactoryBot.create(:exercise, user_id: user.id, name: "clam shells", description: "lie on one side with legs bent at knees", default_per_side: true)
FactoryBot.create(:exercise, user_id: user.id, name: "wall slides", description: "lie on side with body flat against wall. raise leg up, sliding heel againt wall.", default_per_side: true)
FactoryBot.create(:exercise, user_id: user.id, name: "bridges", description: "lie on back with legs bent at knees. lift butt up.")
FactoryBot.create(:exercise, user_id: user.id, name: "cross-body isometrics", description: "lie on back with legs bent at knees. bring right knee towards chest but push back with left hand. hold and engage core. alternate sides.")

#------------------------------------------
puts "Seeding Body Parts"
body_part_names = ["hip, right", "hip, left", "knee, right", "knee, left", "head"]

body_part_names.each do |body_part_name|
  FactoryBot.create(:body_part, user_id: user.id, name: body_part_name)
end

#------------------------------------------
puts "Seeding Pains"
pain_names = ["none", "aching", "burning", "throbbing", "stabbing", "stiffness"]

pain_names.each do |pain_name|
  FactoryBot.create(:pain, user_id: user.id, name: pain_name)
end

#-------------------------------------------
#              BUILD LOGS
#-------------------------------------------
puts "Seeding Logs..."
Rake::Task["db:seed:exercise_logs"].invoke(user.id, 30)
Rake::Task["db:seed:pain_logs"].invoke(user.id, 30)
Rake::Task["db:seed:pt_session_logs"].invoke(user.id, 30)
Rake::Task["db:seed:slit_logs"].invoke(user.id, 90)

puts "Done."
