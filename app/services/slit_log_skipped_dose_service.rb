# frozen_string_literal: true

class SlitLogSkippedDoseService
  class << self
    def call
      User.with_slit_enabled.each do |user|
        puts "==============SlitLogSkippedDoseService=================="
        puts "user: #{user.email}"
        last_log = user.slit_logs.order(occurred_at: :desc).limit(1).first
        puts "last_log: #{last_log.occurred_at}"
        puts "last_log.occurred_at.to_date: #{last_log.occurred_at.to_date}"
        puts "Date.yesterday: #{Date.yesterday}"
        puts "no_log_yesterday?: #{no_log_yesterday?(last_log)}"
        puts "yes log yesterday: #{last_log&.occurred_at&.to_date == Date.yesterday}"
        next unless no_log_yesterday?(last_log)
        puts "DateTime.yesterday: #{DateTime.yesterday}"
        puts "Creating SLIT log for: #{DateTime.yesterday}"
        user.slit_logs.create(occurred_at: DateTime.yesterday, dose_skipped: true)
        puts "========================================================="
      end
    end

    private

    def no_log_yesterday?(last_log)
      last_log.nil? || (last_log.occurred_at.to_date != Date.yesterday)
    end
  end
end
