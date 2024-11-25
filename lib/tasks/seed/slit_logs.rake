# frozen_string_literal: true

namespace :db do
  namespace :seed do
    desc "Create SLIT Logs"
    task :slit_logs, [:user_id, :quantity] => [:environment] do |_task, args|
      SlitLog.destroy_all

      puts "Seeding SLIT Logs"
      user_id = if args[:user_id].present?
        args[:user_id]
      else
        existing_user = User.find_by(email: "admin@email.com", admin: true)
        existing_user.present? ? existing_user.id : FactoryBot.create(:user, first_name: "Admin", last_name: "McAdmins", email: "admin@email.com", admin: true).id
      end

      quantity = args[:quantity].presence || 90
      start_date = DateTime.current - quantity

      quantity.times do |i|
        FactoryBot.create(
          :slit_log,
          user_id: user_id,
          started_new_bottle: (i % 45 == 0),
          dose_skipped: i != 0 && (i % 13 == 0),
          occurred_at: (start_date + i + 1)
        )
      end
    end
  end
end
