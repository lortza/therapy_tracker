# frozen_string_literal: true

puts 'Destroying all assets'
# User.destroy_all
Exercise.destroy_all
ExerciseLog.destroy_all
PainLog.destroy_all
PhysicalTherapySession.destroy_all
Pain.destroy_all
BodyPart.destroy_all

puts 'Building Users'
# user = User.create!(first_name: 'Admin', last_name: 'McAdmins', email: 'admin@example.com', admin: true, password: 'password', password_confirmation: 'password')
# User.create!(first_name: 'User1First', last_name: 'User1Last', email: 'user1@example.com', admin: false, password: 'password', password_confirmation: 'password')

user = User.first
puts 'Building Exercises'
Exercise.create!([
  { user_id: user.id, default_sets: 3, default_reps: 10, default_rep_length: 2, name: 'clam shells', description: 'lie on one side with legs bent at knees' }
  { user_id: user.id, default_sets: 3, default_reps: 10, default_rep_length: 5, name: 'bridges', description: 'lie on back with legs bent at knees. lift butt up.' }
])

puts 'Building Body Parts'
BodyPart.create!([
  { user_id: user.id, name: 'hip - right' },
  { user_id: user.id, name: 'hip - left' },
  { user_id: user.id, name: 'knee - right' },
  { user_id: user.id, name: 'knee - left' },
])
body_part = BodyPart.first

puts 'Building Pains'
Pain.create!([
  { user_id: user.id, name: 'aching' },
  { user_id: user.id, name: 'burning' },
  { user_id: user.id, name: 'tearing' },
  { user_id: user.id, name: 'throbbing' },
  { user_id: user.id, name: 'stabbing' },
])
pain = Pain.sample


puts 'Building Logs'
exercise = Exercise.first
ExerciseLog.create!([
  { user_id: user.id, sets: 3, reps: 10, exercise_id: exercise.id, datetime_occurred: "2019-03-23 19:29:00", rep_length: 2, progress_note: "hip generally feels more supported, but pain is still very present", body_part_id: body_part.id },
  { user_id: user.id, sets: 3, reps: 10, exercise_id: exercise.id, datetime_occurred: "2019-03-24 09:30:00", rep_length: 2, progress_note: "feeling good this morning. hip cracked during exercise and that felt nice.", body_part_id: body_part.id },
  { user_id: user.id, sets: 3, reps: 10, exercise_id: exercise.id, datetime_occurred: "2019-03-21 15:30:00", rep_length: 1, progress_note: "left hip feels weaker than right. Didn’t notice much of a difference after this session. walking to my car was kind of painful: 1.\r\n", body_part_id: body_part.id },
  { user_id: user.id, sets: 3, reps: 10, exercise_id: exercise.id, datetime_occurred: "2019-03-21 18:00:00", rep_length: 2, progress_note: "Went for a walk right afterwards. We did 1 little loop and i was not feeling any(? much?) pain, so we did another small loop. Now I’d like to rest my hips. Stil feeling burning when sitting with feet on floor and with legs elevated.", body_part_id: body_part.id },
  { user_id: user.id, sets: 3, reps: 10, exercise_id: exercise.id, datetime_occurred: "2019-03-22 06:30:00", rep_length: 3, progress_note: "left hip feels weaker than right also, hip is a little sore this morning in the joint. it doesn’t feel like workout sore. Usual pain in usual places, but i feel more confident and optimistic.", body_part_id: body_part.id },
  { user_id: user.id, sets: 3, reps: 10, exercise_id: exercise.id, datetime_occurred: "2019-03-22 17:00:00", rep_length: 2, progress_note: "left hip still feels weaker than right. weird. no muscle soreness from exercise. Went for little walk around block right afterwards. My hip feels more supported than before, but i’m still kind of walking funny.", body_part_id: body_part.id },
  { user_id: user.id, sets: 3, reps: 10, exercise_id: exercise.id, datetime_occurred: "2019-03-23 10:00:00", rep_length: 2, progress_note: "left hip feels weaker than right also, hip is a little sore this morning in the joint. it doesn’t feel like workout sore.", body_part_id: body_part.id }
])

PainLog.create!([
  { user_id: user.id, pain_id: pain.id, datetime_occurred: 'Mon, 25 Mar 2019 19:30:00 UTC +00:00', body_part_id: body_part.id, pain_level: 3, pain_description: "lower back of hip felt dull and achey", trigger: "standing and cooking" },
])

PhysicalTherapySession.create!([
  { user_id: user.id,
    datetime_occurred: 'Thur, 21 Mar 2019 14:00:00 UTC +00:00',
    body_part_id: body_part.id,
    exercise_notes: "clamshells: 3 sets 10 reps each side",
    homework: "clamshells: 3 sets 10 reps each side",
    duration: 60 },
  { user_id: user.id,
    datetime_occurred: 'Mon, 25 Mar 2019 08:00:00 UTC +00:00',
    body_part_id: body_part.id,
    exercise_notes: "clamshells + yellow band: 3 sets 10 reps each side\r\n\r\ncross body isometrics: 5 second push, 10 reps each leg\r\n\r\nbridges: 3 sets 10 reps, 10 second hold\r\n\r\nstrap stretch hams: 1 set 10 reps each leg. lift leg straight up with strap and hold for 10 sec\r\n\r\nstrap stretch quad: 10 set 10 reps hold for 10 seconds\r\n\r\ncrouch walk with band: 2 laps\r\n\r\nsquats on machine: 2 sets 10 reps",
    homework: "clamshells: 3 sets 10 reps each side\r\n\r\ncross body isometrics: 5 second push, 10 reps each leg\r\n\r\nbridges: 3 sets 10 reps, 10 second hold",
    duration: 90 },
])

ExerciseLog.all.each do |log|
  if log.burn_rep == nil
    log.burn_set = 0
    log.burn_rep = 0
  else
    nums = log.burn_rep.to_s.split('.')
    log.burn_set = nums.first.to_i
    log.burn_rep = nums.last.to_i
  end
  log.save
end

[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.7, 2.14, 0.0, 2.5, 2.5, 0.0, 0.0, 3.2, 2.13, 2.5, 0.0, 0.0, nil, 2.7, 2.5, 0.0, 3.5, 2.5, nil, nil, 2.7, nil, 0.0, 3.7, 2.8, 2.8, nil, 0.0, 0.0, 0.0, nil, 0.0, nil, 3.7, 2.8, nil, nil, nil, nil, nil, nil, nil, 0.0, nil, nil, nil, nil, nil, nil, 3.6, 0.0, 2.2, 0.0, nil, nil, nil, nil, nil, 0.0, nil, 0.0, 3.5, nil, nil, nil, nil, nil, nil, nil, nil, 0.0, 3.6, 2.5, nil, 1.6, nil, 0.0, 0.0, nil, 3.6, nil, nil, 0.0, 2.1, nil]
