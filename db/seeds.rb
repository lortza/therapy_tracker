puts 'Destroying all assets'
# User.destroy_all
ExerciseLog.destroy_all

puts 'Building Users'
# user = User.create!(first_name: 'Admin', last_name: 'McAdmins', email: 'admin@example.com', admin: true, password: 'password', password_confirmation: 'password')
# User.create!(first_name: 'User1First', last_name: 'User1Last', email: 'user1@example.com', admin: false, password: 'password', password_confirmation: 'password')

puts 'Building Logs'
user = User.first
ExerciseLog.create!([
  {user_id: user.id, sets: 3, reps: 10, exercise_name: "clam shells", datetime_occurred: "2019-03-23 19:29:00", current_pain_level: 2, current_pain_frequency: "nearly constant", progress_note: "hip generally feels more supported, but pain is still very present", target_body_part: "hip - right"},
  {user_id: user.id, sets: 3, reps: 10, exercise_name: "clam shells", datetime_occurred: "2019-03-24 09:30:00", current_pain_level: 2, current_pain_frequency: "only when provoked", progress_note: "feeling good this morning. hip cracked during exercise and that felt nice.", target_body_part: "hip - right"},
  {user_id: user.id, sets: 3, reps: 10, exercise_name: "clam shells", datetime_occurred: "2019-03-21 15:30:00", current_pain_level: 1, current_pain_frequency: "most of day", progress_note: "left hip feels weaker than right. Didn’t notice much of a difference after this session. walking to my car was kind of painful: 1.\r\n", target_body_part: "hip - right"},
  {user_id: user.id, sets: 3, reps: 10, exercise_name: "clam shells", datetime_occurred: "2019-03-21 18:00:00", current_pain_level: 2, current_pain_frequency: "most of day", progress_note: "Went for a walk right afterwards. We did 1 little loop and i was not feeling any(? much?) pain, so we did another small loop. Now I’d like to rest my hips. Stil feeling burning when sitting with feet on floor and with legs elevated.", target_body_part: "hip - right"},
  {user_id: user.id, sets: 3, reps: 10, exercise_name: "clam shells", datetime_occurred: "2019-03-22 06:30:00", current_pain_level: 3, current_pain_frequency: "constant", progress_note: "left hip feels weaker than right also, hip is a little sore this morning in the joint. it doesn’t feel like workout sore. Usual pain in usual places, but i feel more confident and optimistic.", target_body_part: "hip - right"},
  {user_id: user.id, sets: 3, reps: 10, exercise_name: "clam shells", datetime_occurred: "2019-03-22 17:00:00", current_pain_level: 2, current_pain_frequency: "most of day", progress_note: "left hip still feels weaker than right. weird. no muscle soreness from exercise. Went for little walk around block right afterwards. My hip feels more supported than before, but i’m still kind of walking funny.", target_body_part: "hip - right"},
  {user_id: user.id, sets: 3, reps: 10, exercise_name: "clam shells", datetime_occurred: "2019-03-23 10:00:00", current_pain_level: 2, current_pain_frequency: "part of day", progress_note: "left hip feels weaker than right also, hip is a little sore this morning in the joint. it doesn’t feel like workout sore.", target_body_part: "hip - right"}
])
