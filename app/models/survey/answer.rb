# frozen_string_literal: true

# == Schema Information
#
# Table name: survey_answers
#
#  id                      :uuid             not null, primary key
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  survey_answer_option_id :uuid             not null
#  survey_question_id      :uuid             not null
#  survey_response_id      :uuid             not null
#
# Indexes
#
#  idx_on_survey_response_id_survey_question_id_91571cee66  (survey_response_id,survey_question_id)
#  index_survey_answers_on_survey_answer_option_id          (survey_answer_option_id)
#  index_survey_answers_on_survey_question_id               (survey_question_id)
#  index_survey_answers_on_survey_response_id               (survey_response_id)
#
# Foreign Keys
#
#  fk_rails_...  (survey_answer_option_id => survey_answer_options.id)
#  fk_rails_...  (survey_question_id => survey_questions.id)
#  fk_rails_...  (survey_response_id => survey_responses.id)

class Survey::Answer < ApplicationRecord
  # A Survey::Answer represents a user's answer to a specific survey question
  # as part of a survey response. There is one survey_answer per survey_question.
  # It captures the user's selected answer_option for that question
  # in the context of their overall response to the survey.

  belongs_to :response, class_name: "Survey::Response", foreign_key: "survey_response_id", inverse_of: :answers
  belongs_to :question, class_name: "Survey::Question", foreign_key: "survey_question_id"
  belongs_to :answer_option, class_name: "Survey::AnswerOption", foreign_key: "survey_answer_option_id"

  after_save :calculate_response_total_score

  delegate :value, to: :answer_option, prefix: true

  private

  def calculate_response_total_score
    response.update(total_score: response.calculate_total_score)
  end
end
