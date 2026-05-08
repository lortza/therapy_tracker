# frozen_string_literal: true

require "rails_helper"

RSpec.describe SurveysHelper, type: :helper do
  describe "#display_score_range_steps?" do
    let(:survey) { build_stubbed(:survey) }
    let(:answer_options) { double("answer_options") }

    before do
      allow(survey).to receive_message_chain(:questions, :any?).and_return(true)
      allow(survey).to receive(:answer_options).and_return(answer_options)
      allow(answer_options).to receive(:presence).and_return(answer_options)
      allow(answer_options).to receive(:maximum).with(:value).and_return(1)
    end

    context "when all conditions are met" do
      it "returns true" do
        expect(helper.display_score_range_steps?(survey)).to be(true)
      end
    end

    context "when the survey has no questions" do
      before { allow(survey).to receive_message_chain(:questions, :any?).and_return(false) }

      it "returns false" do
        expect(helper.display_score_range_steps?(survey)).to be(false)
      end
    end

    context "when the survey has no answer_options" do
      before { allow(answer_options).to receive(:presence).and_return(nil) }

      it "returns falsy" do
        expect(helper.display_score_range_steps?(survey)).to be_falsy
      end
    end

    context "when the maximum answer option value is not greater than 0" do
      before { allow(answer_options).to receive(:maximum).with(:value).and_return(0) }

      it "returns false" do
        expect(helper.display_score_range_steps?(survey)).to be(false)
      end
    end
  end

  describe "#difference_from_previous_response_score" do
    let(:current_response) { build_stubbed(:survey_response, total_score: 15) }

    context "when there is no previous response" do
      before { allow(current_response).to receive(:previous_response).and_return(nil) }

      it "returns 0" do
        expect(helper.difference_from_previous_response_score(current_response)).to eq(0)
      end
    end

    context "when there is a previous response with a lower score" do
      let(:previous_response) { build_stubbed(:survey_response, total_score: 10) }
      before { allow(current_response).to receive(:previous_response).and_return(previous_response) }

      it "returns the positive difference" do
        expect(helper.difference_from_previous_response_score(current_response)).to eq(5)
      end
    end

    context "when there is a previous response with a higher score" do
      let(:previous_response) { build_stubbed(:survey_response, total_score: 20) }
      before { allow(current_response).to receive(:previous_response).and_return(previous_response) }

      it "returns the negative difference" do
        expect(helper.difference_from_previous_response_score(current_response)).to eq(-5)
      end
    end

    context "when there is a previous response with an equal score" do
      let(:previous_response) { build_stubbed(:survey_response, total_score: 15) }
      before { allow(current_response).to receive(:previous_response).and_return(previous_response) }

      it "returns 0" do
        expect(helper.difference_from_previous_response_score(current_response)).to eq(0)
      end
    end
  end

  describe "survey_response_count_for_user" do
    let(:survey) { create(:survey) }
    let(:user) { create(:user) }

    it "returns the count of responses for the given survey and user" do
      create_list(:survey_response, 3, survey: survey, user: user)
      create(:survey_response, survey: survey, user: create(:user)) # other user's response
      create(:survey_response, user: user) # response for other survey

      expect(helper.survey_response_count_for_user(survey: survey, user: user)).to eq(3)
    end

    it "excludes survey responses made by other users" do
      create_list(:survey_response, 3, survey: survey, user: user)
      create(:survey_response, survey: survey, user: create(:user)) # other user's response
      create(:survey_response, user: user) # response for other survey

      expect(helper.survey_response_count_for_user(survey: survey, user: user)).to eq(3)
    end
  end

  describe "survey_response_avg_score_for_user" do
    let(:survey) { create(:survey) }
    let(:other_survey) { create(:survey) }
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:category) { create(:survey_category, survey: survey) }
    let(:question) { create(:survey_question, category: category) }
    let(:opt_5) { create(:survey_answer_option, survey: survey, value: 5) }
    let(:opt_3) { create(:survey_answer_option, survey: survey, value: 3) }
    let(:opt_1) { create(:survey_answer_option, survey: survey, value: 1) }

    # Build a response with one answer so Survey::Response#calculate_total_score
    # populates total_score from real data instead of being clobbered by the before_save.
    def build_response(user:, survey:, question:, answer_option:)
      response = create(:survey_response, user: user, survey: survey)
      create(:survey_answer, response: response, question: question, answer_option: answer_option)
      response.reload
    end

    it "returns the average total_score across the user's responses for the survey" do
      build_response(user: user, survey: survey, question: question, answer_option: opt_5)
      build_response(user: user, survey: survey, question: question, answer_option: opt_3)
      build_response(user: user, survey: survey, question: question, answer_option: opt_1)

      expect(helper.survey_response_avg_score_for_user(survey: survey, user: user)).to eq(3.0)
    end

    it "excludes responses belonging to other users" do
      build_response(user: user, survey: survey, question: question, answer_option: opt_5)
      build_response(user: other_user, survey: survey, question: question, answer_option: opt_1)

      expect(helper.survey_response_avg_score_for_user(survey: survey, user: user)).to eq(5.0)
    end

    it "excludes responses for other surveys" do
      other_category = create(:survey_category, survey: other_survey)
      other_question = create(:survey_question, category: other_category)
      other_opt = create(:survey_answer_option, survey: other_survey, value: 4)

      build_response(user: user, survey: survey, question: question, answer_option: opt_5)
      build_response(user: user, survey: other_survey, question: other_question, answer_option: other_opt)

      expect(helper.survey_response_avg_score_for_user(survey: survey, user: user)).to eq(5.0)
    end

    it "rounds the average to 2 decimal places" do
      opt_2 = create(:survey_answer_option, survey: survey, value: 2)
      build_response(user: user, survey: survey, question: question, answer_option: opt_5)
      build_response(user: user, survey: survey, question: question, answer_option: opt_3)
      build_response(user: user, survey: survey, question: question, answer_option: opt_2)
      # (5 + 3 + 2) / 3 = 3.3333...

      expect(helper.survey_response_avg_score_for_user(survey: survey, user: user)).to eq(3.33)
    end

    it "returns nil when the user has no responses for the survey" do
      expect(helper.survey_response_avg_score_for_user(survey: survey, user: user)).to be_nil
    end
  end
end
