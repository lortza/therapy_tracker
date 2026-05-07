# frozen_string_literal: true

require "rails_helper"

RSpec.describe SurveysHelper, type: :helper do
  describe "#display_score_range_steps?" do
    let(:survey) { build_stubbed(:survey) }

    before do
      allow(helper).to receive(:allowed_to?).and_return(true)
      allow(survey).to receive_message_chain(:questions, :any?).and_return(true)
      allow(survey).to receive_message_chain(:answer_options, :maximum).and_return(1)
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

    context "when the maximum answer option value is not greater than 0" do
      before { allow(survey).to receive_message_chain(:answer_options, :maximum).and_return(0) }

      it "returns false" do
        expect(helper.display_score_range_steps?(survey)).to be(false)
      end
    end
  end
end
