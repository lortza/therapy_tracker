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
#
FactoryBot.define do
  factory :survey_answer, class: Survey::Answer do
    association :response, factory: :survey_response
    association :question, factory: :survey_question
    association :answer_option, factory: :survey_answer_option

    # response { association(:survey_response) }
    # question { association(:survey_question) }
    # answer_option { association(:survey_answer_option) }
  end
end
