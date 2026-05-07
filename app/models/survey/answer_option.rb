# frozen_string_literal: true

# == Schema Information
#
# Table name: survey_answer_options
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  value      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  survey_id  :uuid             not null
#
# Indexes
#
#  index_survey_answer_options_on_survey_id  (survey_id)
#
# Foreign Keys
#
#  fk_rails_...  (survey_id => surveys.id)

class Survey::AnswerOption < ApplicationRecord
  # A Survey::AnswerOption represents a possible answer to a survey question for all questions in this survey.
  # For example, for the question "how often have you felt hopeless?", the answer options might be "0 - Not at all",
  # "1 - Several days", "2 - More than half the days", and "3 - Nearly every day".
  # Each answer option has a value that is referenced to calculate the overall score for the survey response.

  belongs_to :survey
  has_many :answers, class_name: "Survey::Answer", foreign_key: "survey_answer_option_id", dependent: :destroy

  validates :value,
    presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: 0},
    uniqueness: {scope: :survey_id}

  normalizes :name, with: ->(name) { name.strip.squish }
  validates :name,
    presence: true,
    uniqueness: {scope: :survey_id, case_sensitive: false}

  scope :ordered, -> { order(value: :asc) }

  after_save :update_survey_question_min_and_max_point_values
  after_destroy :update_survey_question_min_and_max_point_values

  private

  def update_survey_question_min_and_max_point_values
    survey.calculate_min_and_max_points!
  end
end
