# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::Survey::ScoreRangeStepPolicy, type: :policy do
  let(:admin_user) { build_stubbed(:user, admin: true) }
  let(:other_user) { build_stubbed(:user, admin: false) }
  let(:policy) { described_class.new(record, user: current_user) }

  # new?/create?/edit?/update? require survey policy edit? AND survey has questions.
  # destroy? only requires survey policy edit?.

  context "when the survey policy permits edit and the survey has questions" do
    let(:current_user) { admin_user }
    let(:survey) { build_stubbed(:survey, status: :draft, available_to_public: false, user_id: admin_user.id) }
    let(:record) { build_stubbed(:survey_score_range_step, survey: survey) }

    before { allow(survey).to receive_message_chain(:questions, :any?).and_return(true) }

    it "permits new?" do
      expect(policy.apply(:new?)).to eq(true)
    end

    it "permits create?" do
      expect(policy.apply(:create?)).to eq(true)
    end

    it "permits edit?" do
      expect(policy.apply(:edit?)).to eq(true)
    end

    it "permits update?" do
      expect(policy.apply(:update?)).to eq(true)
    end

    it "permits destroy?" do
      expect(policy.apply(:destroy?)).to eq(true)
    end
  end

  context "when the survey policy permits edit but the survey has no questions" do
    let(:current_user) { admin_user }
    let(:survey) { build_stubbed(:survey, status: :draft, available_to_public: false, user_id: admin_user.id) }
    let(:record) { build_stubbed(:survey_score_range_step, survey: survey) }

    before { allow(survey).to receive_message_chain(:questions, :any?).and_return(false) }

    it "denies new?" do
      expect(policy.apply(:new?)).to eq(false)
    end

    it "denies create?" do
      expect(policy.apply(:create?)).to eq(false)
    end

    it "denies edit?" do
      expect(policy.apply(:edit?)).to eq(false)
    end

    it "denies update?" do
      expect(policy.apply(:update?)).to eq(false)
    end

    it "still permits destroy?" do
      expect(policy.apply(:destroy?)).to eq(true)
    end
  end

  context "when the survey policy denies edit (non-admin user)" do
    let(:current_user) { other_user }
    let(:survey) { build_stubbed(:survey, status: :draft, available_to_public: true, user_id: other_user.id) }
    let(:record) { build_stubbed(:survey_score_range_step, survey: survey) }

    before { allow(survey).to receive_message_chain(:questions, :any?).and_return(true) }

    it "denies new?" do
      expect(policy.apply(:new?)).to eq(false)
    end

    it "denies create?" do
      expect(policy.apply(:create?)).to eq(false)
    end

    it "denies edit?" do
      expect(policy.apply(:edit?)).to eq(false)
    end

    it "denies update?" do
      expect(policy.apply(:update?)).to eq(false)
    end

    it "denies destroy?" do
      expect(policy.apply(:destroy?)).to eq(false)
    end
  end
end
