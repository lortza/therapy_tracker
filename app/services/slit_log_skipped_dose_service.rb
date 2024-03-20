# frozen_string_literal: true

class SlitLogSkippedDoseService
  class << self
    def call
      User.with_slit_enabled.each do |user|
        Rails.logger.debug "==============SlitLogSkippedDoseService=================="
        Rails.logger.debug "user: #{user.email}"
        last_log = user.slit_logs.order(occurred_at: :desc).limit(1).first
        Rails.logger.debug "last_log: #{last_log.occurred_at}"
        Rails.logger.debug "last_log.occurred_at.to_date: #{last_log.occurred_at.to_date}"
        Rails.logger.debug "Date.yesterday: #{Date.yesterday}"
        Rails.logger.debug "no_log_yesterday?: #{no_log_yesterday?(last_log)}"
        Rails.logger.debug "yes log yesterday: #{last_log&.occurred_at&.to_date == Date.yesterday}"
        next unless no_log_yesterday?(last_log)
        Rails.logger.debug "DateTime.yesterday: #{DateTime.yesterday}"
        Rails.logger.debug "Creating SLIT log for: #{DateTime.yesterday}"
        user.slit_logs.create(occurred_at: DateTime.yesterday, dose_skipped: true)
        Rails.logger.debug "========================================================="
      end

      private

      def no_log_yesterday?(last_log)
        last_log.nil? || (last_log.occurred_at.to_date != Date.yesterday)
      end
    end
  end
end
