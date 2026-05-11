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

  describe "score_range_step" do
    let(:survey) { create(:survey) }
    let(:survey_response) { create(:survey_response, survey: survey) }

    it "returns the score range step whose range includes the total score" do
      matching_step = create(:survey_score_range_step, survey: survey, calculated_range_min_points: 0, calculated_range_max_points: 10)
      create(:survey_score_range_step, survey: survey, calculated_range_min_points: 11, calculated_range_max_points: 20)

      allow(survey_response).to receive(:total_score).and_return(5)

      expect(survey_response.score_range_step).to eq(matching_step)
    end

    it "returns nil when no score range step covers the total score" do
      create(:survey_score_range_step, survey: survey, calculated_range_min_points: 11, calculated_range_max_points: 20)

      allow(survey_response).to receive(:total_score).and_return(5)

      expect(survey_response.score_range_step).to be_nil
    end
  end

  describe "previous_response" do
    let(:survey) { create(:survey) }
    let(:user) { create(:user) }

    it "returns the most recent response for the same user and survey before the current response" do
      older = create(:survey_response, survey: survey, user: user, occurred_at: 3.days.ago)
      newer = create(:survey_response, survey: survey, user: user, occurred_at: 2.days.ago)
      current = create(:survey_response, survey: survey, user: user, occurred_at: 1.day.ago)

      expect(current.previous_response).to eq(newer)
      expect(newer.previous_response).to eq(older)
      expect(older.previous_response).to be_nil
    end

    it "does not return responses from a different user" do
      other_user = create(:user)
      create(:survey_response, survey: survey, user: other_user, occurred_at: 2.days.ago)
      current = create(:survey_response, survey: survey, user: user, occurred_at: 1.day.ago)

      expect(current.previous_response).to be_nil
    end

    it "does not return responses from a different survey" do
      other_survey = create(:survey)
      create(:survey_response, survey: other_survey, user: user, occurred_at: 2.days.ago)
      current = create(:survey_response, survey: survey, user: user, occurred_at: 1.day.ago)

      expect(current.previous_response).to be_nil
    end
  end
end
