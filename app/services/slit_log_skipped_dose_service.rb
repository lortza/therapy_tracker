# frozen_string_literal: true

class SlitLogSkippedDoseService
  def self.call
    User.with_slit_enabled.each do |user|
      last_log = user.slit_logs.order(occurred_at: :desc).limit(1).first
      next unless last_log.nil? || (last_log.occurred_at.to_date != Date.yesterday)

      user.slit_logs.create(occurred_at: DateTime.yesterday, dose_skipped: true)
    end
  end
end
