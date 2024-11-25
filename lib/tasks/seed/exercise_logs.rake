# frozen_string_literal: true

namespace :db do
  namespace :seed do
    desc "Create Exercise Logs"
    task :exercise_logs, [:user_id, :quantity] => [:environment] do |_task, args|
      ExerciseLog.destroy_all

      user_id = if args[:user_id].present?
        args[:user_id]
      else
        existing_user = User.find_by(email: "admin@email.com", admin: true)
        existing_user.present? ? existing_user.id : FactoryBot.create(:user, first_name: "Admin", last_name: "McAdmins", email: "admin@email.com", admin: true).id
      end

      quantity = args[:quantity].presence || 30

      puts "Seeding Exercise Logs"
      progress_notes = [
        "generally feels more supported, but pain is still very present",
        "feeling good this morning. hip cracked during exercise and that felt nice.",
        "feels weaker than other side. Didn’t notice much of a difference after this session.",
        "Went for a walk right afterwards. We did 1 little loop and i was not feeling much pain, so we did another small loop.",
        "feels weaker than right also, hip is a little sore this morning in the joint. it doesn’t feel like workout sore.",
        "still feels weaker than other side. weird. no muscle soreness from exercise.",
        "feels weaker than other side also is a little sore this morning in the joint."
      ]

      quantity.times do
        FactoryBot.create(
          :exercise_log,
          user_id: user_id,
          body_part_id: BodyPart.all.sample.id,
          exercise_id: Exercise.all.sample.id,
          occurred_at: Faker::Time.between(from: 3.month.ago, to: DateTime.current),
          progress_note: progress_notes.sample
        )
      end
    end
  end
end
