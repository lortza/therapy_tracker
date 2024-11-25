# frozen_string_literal: true

namespace :db do
  namespace :seed do
    desc 'Create Pain Logs'
    task :pain_logs, [:user_id, :quantity] => [:environment] do |_task, args|
      PainLog.destroy_all

      user_id = if args[:user_id].present?
        args[:user_id]
      else
        existing_user = User.find_by(email: 'admin@email.com', admin: true)
        existing_user.present? ? existing_user.id : FactoryBot.create(:user, first_name: 'Admin', last_name: 'McAdmins', email: 'admin@email.com', admin: true).id
      end

      quantity = args[:quantity].presence || 30

      puts 'Seeding Pain Logs'
      quantity.times do
        FactoryBot.create(
          :pain_log,
          user_id: user_id,
          body_part_id: BodyPart.all.sample.id,
          pain_id: Pain.all.sample.id,
          occurred_at: Faker::Time.between(from: 3.month.ago, to: DateTime.current)
        )
      end
    end
  end
end
