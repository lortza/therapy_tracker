# == Schema Information
#
# Table name: slit_logs
#
#  id                 :bigint           not null, primary key
#  dose_skipped       :boolean
#  doses_remaining    :integer
#  occurred_at        :datetime
#  started_new_bottle :boolean          default(FALSE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :bigint           not null
#
# Indexes
#
#  index_slit_logs_on_occurred_at  (occurred_at)
#  index_slit_logs_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

# frozen_string_literal: true

class SlitLog < ApplicationRecord
  belongs_to :user

  validates :occurred_at, presence: true

  before_save :set_doses_remaining

  MAX_BOTTLE_DOSES = 45
  COUNTDOWN_TIMER_DEFAULT_SECONDS = 121

  private

  def set_doses_remaining
    return if doses_remaining.present?

    if started_new_bottle?
      self.doses_remaining = user.slit_configuration&.max_bottle_doses || MAX_BOTTLE_DOSES
    else
      previous_balance = previous_log&.doses_remaining
      return nil if previous_balance.blank?

      self.doses_remaining = calculate_doses_remaining(previous_balance)
    end
  end

  def previous_log
    current_stamp = DateTime.current
    SlitLog.where("occurred_at < ?", current_stamp).order(occurred_at: :desc).first
  end

  def calculate_doses_remaining(previous_log_doses_remaining)
    if dose_skipped?
      previous_log_doses_remaining
    elsif previous_log_doses_remaining.positive?
      previous_log_doses_remaining - 1
    else
      0
    end
  end
end
