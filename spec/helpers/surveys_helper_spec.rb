# frozen_string_literal: true

require "rails_helper"

RSpec.describe SurveysHelper, type: :helper do
  describe "#display_score_range_steps?" do
    let(:survey) { build_stubbed(:survey) }
    let(:answer_options) { double("answer_options") }

    before do
      allow(helper).to receive(:allowed_to?).and_return(true)
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

    context "when the user is not authorized to edit the survey" do
      before { allow(helper).to receive(:allowed_to?).and_return(false) }

      it "returns false" do
        expect(helper.display_score_range_steps?(survey)).to be(false)
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
end
