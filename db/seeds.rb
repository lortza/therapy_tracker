# frozen_string_literal: true

#-------------------------------------------
#             DELETE ALL SEEDS
#-------------------------------------------
puts 'Destroying all assets'
ExerciseLog.destroy_all
PainLog.destroy_all
PtSessionLog.destroy_all
Pain.destroy_all
BodyPart.destroy_all
Exercise.destroy_all
User.destroy_all


#-------------------------------------------
#            BUILD BASE CLASSES
#-------------------------------------------
puts 'Building Users'
user = FactoryBot.create(:user, first_name: 'Admin', last_name: 'McAdmins', email: 'admin@example.com', admin: true)
# user = User.first
#------------------------------------------
puts 'Building Exercises'
FactoryBot.create(:exercise, user_id: user.id, name: 'clam shells', description: 'lie on one side with legs bent at knees', default_per_side: true )
FactoryBot.create(:exercise, user_id: user.id, name: 'wall slides', description: 'lie on side with body flat against wall. raise leg up, sliding heel againt wall.', default_per_side: true )
FactoryBot.create(:exercise, user_id: user.id, name: 'bridges', description: 'lie on back with legs bent at knees. lift butt up.' )
FactoryBot.create(:exercise, user_id: user.id, name: 'cross-body isometrics', description: 'lie on back with legs bent at knees. bring right knee towards chest but push back with left hand. hold and engage core. alternate sides.' )

#------------------------------------------
puts 'Building Body Parts'
body_part_names = ['hip, right', 'hip, left', 'knee, right', 'knee, left']

body_part_names.each do |body_part_name|
  FactoryBot.create(:body_part, user_id: user.id, name: body_part_name)
end

body_part = BodyPart.first

#------------------------------------------
puts 'Building Pains'
pain_names = ['aching', 'burning', 'throbbing', 'stabbing', 'stiffness']

pain_names.each do |pain_name|
  FactoryBot.create(:pain, user_id: user.id, name: pain_name)
end

pain = Pain.all.sample


#-------------------------------------------
#              BUILD LOGS
#-------------------------------------------
puts 'Building Logs'
LOG_MULTIPLIER = 30

def generate_datetime
  h = rand(6..20)
  Faker::Date.between(from: 1.month.ago, to: Date.today).to_datetime + h.hours
end

#------------------------------------------
puts '... Exercise Logs'
  progress_notes = [
    'generally feels more supported, but pain is still very present',
    'feeling good this morning. hip cracked during exercise and that felt nice.',
    'feels weaker than other side. Didn’t notice much of a difference after this session.',
    'Went for a walk right afterwards. We did 1 little loop and i was not feeling much pain, so we did another small loop.',
    'feels weaker than right also, hip is a little sore this morning in the joint. it doesn’t feel like workout sore.',
    'still feels weaker than other side. weird. no muscle soreness from exercise.',
    'feels weaker than other side also is a little sore this morning in the joint.'
  ]

  LOG_MULTIPLIER.times do
    FactoryBot.create(
      :exercise_log,
      user_id: user.id,
      body_part_id: BodyPart.all.sample.id,
      exercise_id: Exercise.all.sample.id,
      occurred_at: generate_datetime,
      progress_note: progress_notes.sample
    )
  end

  #------------------------------------------
  puts '... Pain Logs'
  LOG_MULTIPLIER.times do
    FactoryBot.create(
      :pain_log,
      user_id: user.id,
      body_part_id: BodyPart.all.sample.id,
      pain_id: Pain.all.sample.id,
      occurred_at: generate_datetime
    )
  end

  #------------------------------------------
  puts '... Physical Therapy Session Logs'
  exercise_note_opts = [
    'leveled up this time. used harder band. did one more set on most exercises',
    'tried a new warmup this time. dr says flexibility is good, but need to do more. showed me 2 new stretches.',
    'did strength testing for benchmarks. there is improvement since last week.',
  ]

  homework_notes = [
    'same as session',
    'do regular exercises and incorporate in 1 or two extra sets or reps where you can',
    'regular exercises plus add in an extra walk around the neighborhood',
    'regular exercises plus add in an extra bike ride',
    'try walking as fast as you can to see how far you can get before pain sets in'
  ]

  LOG_MULTIPLIER.times do
    pt_session_log = FactoryBot.create(
      :pt_session_log,
      user_id: user.id,
      body_part_id: BodyPart.all.sample.id,
      occurred_at: generate_datetime,
      exercise_notes: exercise_note_opts.sample,
      homework: homework_notes.sample
    )

    exercise_multiplier = (1..(Exercise.count)).to_a.sample

    exercise_multiplier.times do
      pt_session_log.homework_exercises << Exercise.all.sample
    end

    exercise_multiplier.times do
      FactoryBot.create(:exercise_log, user_id: pt_session_log.user_id, pt_session_log_id: pt_session_log.id, exercise_id: Exercise.all.sample.id)
    end
  end
