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
  # For example, for the question "how often have you felt hopeless?", the answer options might be "Not at all",
  # "Several days", "More than half the days", and "Nearly every day".
  # Each answer option has a value that can be used to calculate a score for the survey response.

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
end
