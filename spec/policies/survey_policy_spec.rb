# frozen_string_literal: true

require "rails_helper"

RSpec.describe SurveyPolicy, type: :policy do
  let(:user) { build_stubbed(:user, admin: false) }
  let(:other_user) { build_stubbed(:user, admin: false) }
  let(:admin_user) { build_stubbed(:user, admin: true) }
  let(:context) { {user: current_user} }

  let(:policy) { described_class.new(record, user: current_user) }

  describe "#index?" do
    subject { policy.apply(:index?) }
    let(:record) { build_stubbed(:survey) }

    context "when the current_user is admin" do
      let(:current_user) { admin_user }

      it "returns true" do
        is_expected.to eq(true)
      end
    end

    context "when the current_user is not admin" do
      let(:current_user) { other_user }

      it "returns false" do
        is_expected.to eq(false)
      end
    end
  end
end
