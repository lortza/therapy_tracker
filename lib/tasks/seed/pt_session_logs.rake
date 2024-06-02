# frozen_string_literal: true

namespace :db do
  namespace :seed do
    desc 'Seed PT Session Logs'
    task :pt_session_logs, [:user_id, :quantity] => [:environment] do |_task, args|
      puts 'Removing all PT Session Logs'
      PtSessionLog.destroy_all

      user_id = if args[:user_id].present?
        binding.pry
        args[:user_id]
      else
        existing_user = User.find_by(email: 'admin@email.com', admin: true)
        existing_user.present? ? existing_user.id : FactoryBot.create(:user, first_name: 'Seeded', last_name: 'Admin', email: 'admin@email.com', admin: true).id
      end

      quantity = args[:quantity].presence || 30

      puts 'Seeding PT Session Logs'
      quantity.times do
        pt_session_log = FactoryBot.create(
          :pt_session_log,
          user_id: user_id,
          body_part_id: BodyPart.all.sample.id,
          occurred_at: Faker::Time.between(from: 3.month.ago, to: DateTime.current),
          exercise_notes: exercise_note_opts.sample,
          homework: homework_notes.sample
        )

        exercise_multiplier = (1..(Exercise.count)).to_a.sample
        pt_session_log.homework_exercises << Exercise.all.sample(exercise_multiplier)

        exercise_multiplier.times do
          FactoryBot.create(
            :exercise_log,
            user_id: user_id,
            pt_session_log_id: pt_session_log.id,
            body_part_id: BodyPart.all.sample.id,
            exercise_id: Exercise.all.sample.id,
            occurred_at: Faker::Time.between(from: 3.month.ago, to: DateTime.current)
          )
        end
      end

    end # task
  end #seed
end # db

def exercise_note_opts
  [
    'leveled up this time. used harder band. did one more set on most exercises',
    'tried a new warmup this time. dr says flexibility is good, but need to do more. showed me 2 new stretches.',
    'did strength testing for benchmarks. there is improvement since last week.',
  ]
end

def homework_notes
  [
    'same as session',
    'do regular exercises and incorporate in 1 or two extra sets or reps where you can',
    'regular exercises plus add in an extra walk around the neighborhood',
    'regular exercises plus add in an extra bike ride',
    'try walking as fast as you can to see how far you can get before pain sets in'
  ]
end
