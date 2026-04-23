# frozen_string_literal: true

# == Schema Information
#
# Table name: survey_responses
#
#  id          :uuid             not null, primary key
#  notes       :text
#  occurred_at :datetime         not null
#  total_score :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  survey_id   :uuid             not null
#  user_id     :bigint           not null
#
# Indexes
#
#  idx_on_user_id_survey_id_occurred_at_2e691e6025  (user_id,survey_id,occurred_at)
#  index_survey_responses_on_survey_id              (survey_id)
#  index_survey_responses_on_user_id                (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (survey_id => surveys.id)
#  fk_rails_...  (user_id => users.id)
#
class Survey::Response < ApplicationRecord
  # A Survey::Response is an instance of the user responding to the survey.
  # It is the container for all of the user's answers to the survey questions,
  # as well as any notes they may have added. It is what receives a total score
  # and what shows up in the user's logs.

  belongs_to :survey
  belongs_to :user
  has_many :answers, class_name: "Survey::Answer", foreign_key: "survey_response_id", dependent: :destroy

  validates :occurred_at, presence: true

  def total_score
    @total_score ||= calculate_total_score
  end

  def calculate_total_score
    answers.sum(&:answer_option_value)
  end

  def score_range_step
    @score_range_step ||= survey.score_range_steps.where("calculated_range_min_points <= ? AND calculated_range_max_points >= ?", total_score, total_score).first
  end

  def previous_response
    @previous_response ||= survey.responses.where(user_id: user_id, occurred_at: ...occurred_at).order(:occurred_at).last
  end
end
