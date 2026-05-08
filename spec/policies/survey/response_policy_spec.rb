# frozen_string_literal: true

require "rails_helper"

RSpec.describe Survey::ResponsePolicy, type: :policy do
  let(:admin_user) { build_stubbed(:user, admin: true) }
  let(:other_user) { build_stubbed(:user, admin: false) }
  let(:record) { build_stubbed(:survey_response) }

  let(:policy) { described_class.new(record, user: current_user) }

  describe "#index?" do
    subject { policy.apply(:index?) }

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

  describe "#new?" do
    subject { policy.apply(:new?) }

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

  describe "#create?" do
    subject { policy.apply(:create?) }

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
