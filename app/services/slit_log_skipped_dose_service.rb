# frozen_string_literal: true

class SlitLogSkippedDoseService
  class << self
    def call
      yesterday = Date.yesterday

      User.with_slit_enabled.each do |user|
        next unless no_log_for_user_yesterday?(user: user, yesterday: yesterday)

        user.slit_logs.create(occurred_at: DateTime.yesterday, dose_skipped: true)
      end
    end

    private

    def no_log_for_user_yesterday?(user:, yesterday:)
      user.slit_logs.where(occurred_at: yesterday.beginning_of_day..yesterday.end_of_day).empty?
    end
  end
end
