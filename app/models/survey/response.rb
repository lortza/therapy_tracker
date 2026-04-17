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
  # as well as any notes they may have added.

  belongs_to :survey
  belongs_to :user
  has_many :answers, class_name: "Survey::Answer", foreign_key: "survey_response_id", dependent: :destroy

  validates :occurred_at, presence: true

  private

  # TODO: populate this with a callback when all survey_answers are completed by the user
  def calculate_total_score
    # Implement logic to calculate total score based on associated survey responses
    # This is a placeholder implementation and should be replaced with actual logic
    self.total_score = 0
  end
end
