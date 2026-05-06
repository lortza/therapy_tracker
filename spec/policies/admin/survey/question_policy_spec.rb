# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::Survey::QuestionPolicy, type: :policy do
  let(:admin_user) { build_stubbed(:user, admin: true) }
  let(:other_user) { build_stubbed(:user, admin: false) }
  let(:policy) { described_class.new(record, user: current_user) }

  # All rules delegate to Admin::SurveyPolicy#edit? via record.category.survey,
  # so we only need to verify the delegation is wired up correctly.

  context "when Admin::SurveyPolicy permits edit (admin who owns a draft survey)" do
    let(:current_user) { admin_user }
    let(:survey) { build_stubbed(:survey, status: :draft, available_to_public: false, user_id: admin_user.id) }
    let(:category) { build_stubbed(:survey_category, survey: survey) }
    let(:record) { build_stubbed(:survey_question, category: category) }

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

  context "when Admin::SurveyPolicy denies edit (non-admin user)" do
    let(:current_user) { other_user }
    let(:survey) { build_stubbed(:survey, status: :draft, available_to_public: true, user_id: other_user.id) }
    let(:category) { build_stubbed(:survey_category, survey: survey) }
    let(:record) { build_stubbed(:survey_question, category: category) }

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
