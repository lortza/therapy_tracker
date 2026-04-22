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
require "rails_helper"

RSpec.describe Survey::Answer, type: :model do
  describe "associations" do
    it { should belong_to(:response) }
    it { should belong_to(:question) }
    it { should belong_to(:answer_option) }
  end

  describe "delegations" do
    it { should delegate_method(:value).to(:answer_option).with_prefix }
  end

  describe "callbacks" do
    describe "calculate_response_total_score" do
      it "updates the response's total_score column after an answer is saved" do
        survey = create(:survey)
        category = create(:survey_category, survey: survey)
        question_1 = create(:survey_question, category: category)
        question_2 = create(:survey_question, category: category)
        option_2 = create(:survey_answer_option, survey: survey, value: 2, name: "Two")
        option_3 = create(:survey_answer_option, survey: survey, value: 3, name: "Three")
        survey_response = create(:survey_response, survey: survey)

        create(:survey_answer, response: survey_response, question: question_1, answer_option: option_2)
        expect(survey_response.reload.read_attribute(:total_score)).to eq(2)

        create(:survey_answer, response: survey_response, question: question_2, answer_option: option_3)
        expect(survey_response.reload.read_attribute(:total_score)).to eq(5) # 2 + 3
      end
    end
  end
end
