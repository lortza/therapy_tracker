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
require "rails_helper"

RSpec.describe Survey::Response, type: :model do
  describe "associations" do
    it { should belong_to(:survey) }
    it { should belong_to(:user) }
    it { should have_many(:answers).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:occurred_at) }
  end

  describe "total_score" do
    let(:survey_response) { create(:survey_response) }
    let(:calculate_total_score_value) { 5 }

    it "returns the value of calculate_total_score" do
      allow(survey_response).to receive(:calculate_total_score).and_return(calculate_total_score_value)
      expect(survey_response.total_score).to eq(calculate_total_score_value)
    end
  end

  describe "calculate_total_score" do
    it "sums the value for all of the answers" do
      survey = create(:survey)
      category = create(:survey_category, survey: survey)
      question_1 = create(:survey_question, category: category)
      question_2 = create(:survey_question, category: category)
      option_2 = create(:survey_answer_option, survey: survey, value: 2, name: "Two")
      option_3 = create(:survey_answer_option, survey: survey, value: 3, name: "Three")
      survey_response = create(:survey_response, survey: survey)

      create(:survey_answer, response: survey_response, question: question_1, answer_option: option_2)
      create(:survey_answer, response: survey_response, question: question_2, answer_option: option_3)

      expect(survey_response.reload.calculate_total_score).to eq(5) # 2 + 3
    end
  end
end
