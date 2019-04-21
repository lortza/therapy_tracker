# frozen_string_literal: true

puts 'Destroying all assets'
  ExerciseLog.destroy_all
  PainLog.destroy_all
  PhysicalTherapySession.destroy_all
  Pain.destroy_all
  BodyPart.destroy_all
  Exercise.destroy_all
  User.destroy_all

puts 'Building Users'
  user = FactoryBot.create(:user, first_name: 'Admin', last_name: 'McAdmins', email: 'admin@example.com', admin: true)

puts 'Building Exercises'
  FactoryBot.create(:exercise, user_id: user.id, name: 'clam shells', description: 'lie on one side with legs bent at knees', default_per_side: true )
  FactoryBot.create(:exercise, user_id: user.id, name: 'bridges', description: 'lie on back with legs bent at knees. lift butt up.' )
  FactoryBot.create(:exercise, user_id: user.id, name: 'cross-body isometrics', description: 'lie on back with legs bent at knees. bring right knee towards chest but push back with left hand. hold and engage core. alternate sides.' )
  FactoryBot.create(:exercise, user_id: user.id, name: 'wall slides', description: 'lie on side with body flat against wall. raise leg up, sliding heel againt wall.' )

puts 'Building Body Parts'
  FactoryBot.create(:body_part, user_id: user.id, name: 'hip, right')
  FactoryBot.create(:body_part, user_id: user.id, name: 'hip, left')
  FactoryBot.create(:body_part, user_id: user.id, name: 'knee, right')
  FactoryBot.create(:body_part, user_id: user.id, name: 'knee, left')
  body_part = BodyPart.first

puts 'Building Pains'
  FactoryBot.create(:pain, user_id: user.id, name: 'aching')
  FactoryBot.create(:pain, user_id: user.id, name: 'burning')
  FactoryBot.create(:pain, user_id: user.id, name: 'throbbing')
  FactoryBot.create(:pain, user_id: user.id, name: 'stabbing')
  FactoryBot.create(:pain, user_id: user.id, name: 'stiffness')
  pain = Pain.all.sample

puts 'Building Logs'
  FactoryBot.create(:exercise_log, user_id: user.id, body_part_id: BodyPart.all.sample.id, exercise_id: Exercise.all.sample.id, datetime_occurred: '2019-03-23 19:29:00', progress_note: 'generally feels more supported, but pain is still very present')
  FactoryBot.create(:exercise_log, user_id: user.id, body_part_id: BodyPart.all.sample.id, exercise_id: Exercise.all.sample.id, datetime_occurred: '2019-03-24 09:30:00', progress_note: 'feeling good this morning. hip cracked during exercise and that felt nice.')
  FactoryBot.create(:exercise_log, user_id: user.id, body_part_id: BodyPart.all.sample.id, exercise_id: Exercise.all.sample.id, datetime_occurred: '2019-03-21 15:30:00', progress_note: 'feels weaker than other side. Didn’t notice much of a difference after this session.')
  FactoryBot.create(:exercise_log, user_id: user.id, body_part_id: BodyPart.all.sample.id, exercise_id: Exercise.all.sample.id, datetime_occurred: '2019-03-21 18:00:00', progress_note: 'Went for a walk right afterwards. We did 1 little loop and i was not feeling much pain, so we did another small loop.')
  FactoryBot.create(:exercise_log, user_id: user.id, body_part_id: BodyPart.all.sample.id, exercise_id: Exercise.all.sample.id, datetime_occurred: '2019-03-22 06:30:00', progress_note: 'feels weaker than right also, hip is a little sore this morning in the joint. it doesn’t feel like workout sore.')
  FactoryBot.create(:exercise_log, user_id: user.id, body_part_id: BodyPart.all.sample.id, exercise_id: Exercise.all.sample.id, datetime_occurred: '2019-03-22 17:00:00', progress_note: 'still feels weaker than other side. weird. no muscle soreness from exercise.')
  FactoryBot.create(:exercise_log, user_id: user.id, body_part_id: BodyPart.all.sample.id, exercise_id: Exercise.all.sample.id, datetime_occurred: '2019-03-23 10:00:00', progress_note: 'feels weaker than other side also, hip is a little sore this morning in the joint.')

  FactoryBot.create(:pain_log, user_id: user.id, body_part_id: BodyPart.all.sample.id, pain_id: Pain.all.sample.id, datetime_occurred: '2019-03-23 10:45:00')
  FactoryBot.create(:pain_log, user_id: user.id, body_part_id: BodyPart.all.sample.id, pain_id: Pain.all.sample.id, datetime_occurred: '2019-03-24 02:00:00')
  FactoryBot.create(:pain_log, user_id: user.id, body_part_id: BodyPart.all.sample.id, pain_id: Pain.all.sample.id, datetime_occurred: '2019-03-25 06:15:00')
  FactoryBot.create(:pain_log, user_id: user.id, body_part_id: BodyPart.all.sample.id, pain_id: Pain.all.sample.id, datetime_occurred: '2019-03-26 07:00:00')
  FactoryBot.create(:pain_log, user_id: user.id, body_part_id: BodyPart.all.sample.id, pain_id: Pain.all.sample.id, datetime_occurred: '2019-03-27 10:00:00')
  FactoryBot.create(:pain_log, user_id: user.id, body_part_id: BodyPart.all.sample.id, pain_id: Pain.all.sample.id, datetime_occurred: '2019-03-28 10:30:00')

  FactoryBot.create(:pt_session, user_id: user.id, body_part_id: BodyPart.all.sample.id, datetime_occurred: '2019-03-24 08:40:00', exercise_notes: 'clamshells + yellow band: 3 sets 10 reps each side, cross body isometrics: 5 second push, 10 reps each leg', homework: 'same as session')
  FactoryBot.create(:pt_session, user_id: user.id, body_part_id: BodyPart.all.sample.id, datetime_occurred: '2019-03-26 05:30:00', exercise_notes: 'bridges: 3 sets 10 reps, 10 second hold, strap stretch hams: 1 set 10 reps each leg. lift leg straight up with strap and hold for 10 sec', homework: 'same as session')
  FactoryBot.create(:pt_session, user_id: user.id, body_part_id: BodyPart.all.sample.id, datetime_occurred: '2019-03-28 04:30:00', exercise_notes: 'strap stretch quad: 10 set 10 reps hold for 10 seconds, crouch walk with band: 2 laps, squats on machine: 2 sets 10 reps', homework: 'same as session')
