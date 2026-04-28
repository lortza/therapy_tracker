# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::SurveyPolicy, type: :policy do
  let(:user) { build_stubbed(:user, admin: false) }
  let(:other_user) { build_stubbed(:user, admin: false) }
  let(:admin_user) { build_stubbed(:user, admin: true) }
  let(:context) { {user: current_user} }

  let(:policy) { described_class.new(record, user: current_user) }

  describe "#index?" do
    subject { policy.apply(:index?) }

    let(:record) { build_stubbed(:survey) }

    context "when the current_user is an admin" do
      let(:current_user) { admin_user }

      it "returns true" do
        is_expected.to eq(true)
      end
    end

    context "when the current_user is NOT an admin" do
      let(:current_user) { other_user }

      it "returns false" do
        is_expected.to eq(false)
      end
    end
  end

  describe "#new?" do
    subject { policy.apply(:new?) }

    let(:record) { build_stubbed(:survey) }

    context "when the current_user is an admin" do
      let(:current_user) { admin_user }

      it "returns true" do
        is_expected.to eq(true)
      end
    end

    context "when the current_user is NOT an admin" do
      let(:current_user) { other_user }

      it "returns false" do
        is_expected.to eq(false)
      end
    end
  end

  describe "#create?" do
    subject { policy.apply(:create?) }

    let(:record) { build_stubbed(:survey) }

    context "when the current_user is an admin" do
      let(:current_user) { admin_user }

      it "returns true" do
        is_expected.to eq(true)
      end
    end

    context "when the current_user is NOT an admin" do
      let(:current_user) { other_user }

      it "returns false" do
        is_expected.to eq(false)
      end
    end
  end

  describe "#show?" do
    subject { policy.apply(:show?) }

    context "when the current_user is not an admin but they own the record" do
      let(:current_user) { other_user }
      let(:record) { build_stubbed(:survey, user_id: other_user.id) }

      it "returns false" do
        is_expected.to eq(false)
      end
    end

    context "when the current_user is not an admin and the survey is available to public" do
      let(:current_user) { other_user }
      let(:record) { build_stubbed(:survey, available_to_public: true, user_id: user.id) }

      it "returns false" do
        is_expected.to eq(false)
      end
    end

    context "when the current_user is an admin" do
      let(:current_user) { admin_user }

      context "and the current_user is the owner but the survey is not available to the public" do
        let(:record) { build_stubbed(:survey, available_to_public: false, user_id: current_user.id) }

        it "returns true" do
          is_expected.to eq(true)
        end
      end

      context "and the current_user is not the owner but the survey is available to the public" do
        let(:record) { build_stubbed(:survey, available_to_public: true, user_id: other_user.id) }

        it "returns true" do
          is_expected.to eq(true)
        end
      end

      context "but the current_user is not the owner and the survey is not available to the public" do
        let(:record) { build_stubbed(:survey, available_to_public: false, user_id: other_user.id) }

        it "returns false" do
          is_expected.to eq(false)
        end
      end
    end

    context "when the current_user is the owner" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, available_to_public: false, user_id: admin_user.id) }
      it "returns true" do
        is_expected.to eq(true)
      end
    end

    context "when the survey is available to the public" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, available_to_public: true, user_id: other_user.id) }
      it "returns true" do
        is_expected.to eq(true)
      end
    end

    context "when the survey is not available to the public and the user is not the owner" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, available_to_public: false, user_id: other_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end
  end

  describe "#edit?" do
    subject { policy.apply(:edit?) }

    context "when the current_user is an admin and owns the survey and it is a draft" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :draft, available_to_public: false, user_id: admin_user.id) }
      it "returns true" do
        is_expected.to eq(true)
      end
    end

    context "when the current_user is an admin and does not own the survey but the survey is public and a draft" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :draft, available_to_public: true, user_id: other_user.id) }
      it "returns true" do
        is_expected.to eq(true)
      end
    end

    context "when the current_user is an admin but does not own the survey and the survey is not public" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :draft, available_to_public: false, user_id: other_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end

    context "when the current_user is an admin and owns the survey but it is published" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :published, available_to_public: false, user_id: admin_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end

    context "when the current_user is an admin and owns the survey but it is archived" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :archived, available_to_public: false, user_id: admin_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end

    context "when the current_user is not an admin" do
      let(:current_user) { other_user }
      let(:record) { build_stubbed(:survey, status: :draft, available_to_public: true, user_id: other_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end
  end

  describe "#update?" do
    subject { policy.apply(:update?) }

    context "when the current_user is an admin and owns the survey and it is a draft" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :draft, available_to_public: false, user_id: admin_user.id) }
      it "returns true" do
        is_expected.to eq(true)
      end
    end

    context "when the current_user is an admin and does not own the survey but the survey is public and a draft" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :draft, available_to_public: true, user_id: other_user.id) }
      it "returns true" do
        is_expected.to eq(true)
      end
    end

    context "when the current_user is an admin but does not own the survey and the survey is not public" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :draft, available_to_public: false, user_id: other_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end

    context "when the current_user is an admin and owns the survey but it is published" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :published, available_to_public: false, user_id: admin_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end

    context "when the current_user is an admin and owns the survey but it is archived" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :archived, available_to_public: false, user_id: admin_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end

    context "when the current_user is not an admin" do
      let(:current_user) { other_user }
      let(:record) { build_stubbed(:survey, status: :draft, available_to_public: true, user_id: other_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end
  end

  describe "#destroy?" do
    subject { policy.apply(:destroy?) }

    context "when the current_user is an admin and owns the survey and it is a draft" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :draft, available_to_public: false, user_id: admin_user.id) }
      it "returns true" do
        is_expected.to eq(true)
      end
    end

    context "when the current_user is an admin and does not own the survey but the survey is public and a draft" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :draft, available_to_public: true, user_id: other_user.id) }
      it "returns true" do
        is_expected.to eq(true)
      end
    end

    context "when the current_user is an admin but does not own the survey and the survey is not public" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :draft, available_to_public: false, user_id: other_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end

    context "when the current_user is an admin and owns the survey but it is published" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :published, available_to_public: false, user_id: admin_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end

    context "when the current_user is an admin and owns the survey but it is archived" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :archived, available_to_public: false, user_id: admin_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end

    context "when the current_user is not an admin" do
      let(:current_user) { other_user }
      let(:record) { build_stubbed(:survey, status: :draft, available_to_public: true, user_id: other_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end
  end

  describe "#publish?" do
    subject { policy.apply(:publish?) }

    context "when the current_user is an admin and owns the survey and it is a draft" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :draft, available_to_public: false, user_id: admin_user.id) }
      it "returns true" do
        is_expected.to eq(true)
      end
    end

    context "when the current_user is an admin and owns the survey and it is archived" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :archived, available_to_public: false, user_id: admin_user.id) }
      it "returns true" do
        is_expected.to eq(true)
      end
    end

    context "when the current_user is an admin and does not own the survey but the survey is public and a draft" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :draft, available_to_public: true, user_id: other_user.id) }
      it "returns true" do
        is_expected.to eq(true)
      end
    end

    context "when the current_user is an admin but does not own the survey and the survey is not public" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :draft, available_to_public: false, user_id: other_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end

    context "when the current_user is an admin and owns the survey but it is already published" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :published, available_to_public: false, user_id: admin_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end

    context "when the current_user is not an admin" do
      let(:current_user) { other_user }
      let(:record) { build_stubbed(:survey, status: :draft, available_to_public: true, user_id: other_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end
  end

  describe "#archive?" do
    subject { policy.apply(:archive?) }

    context "when the current_user is an admin and owns the survey and it is published" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :published, available_to_public: false, user_id: admin_user.id) }
      it "returns true" do
        is_expected.to eq(true)
      end
    end

    context "when the current_user is an admin and does not own the survey but the survey is public and published" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :published, available_to_public: true, user_id: other_user.id) }
      it "returns true" do
        is_expected.to eq(true)
      end
    end

    context "when the current_user is an admin but does not own the survey and the survey is not public" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :published, available_to_public: false, user_id: other_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end

    context "when the current_user is an admin and owns the survey but it is a draft" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :draft, available_to_public: false, user_id: admin_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end

    context "when the current_user is an admin and owns the survey but it is already archived" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :archived, available_to_public: false, user_id: admin_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end

    context "when the current_user is not an admin" do
      let(:current_user) { other_user }
      let(:record) { build_stubbed(:survey, status: :published, available_to_public: true, user_id: other_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end
  end

  describe "#make_public?" do
    subject { policy.apply(:make_public?) }

    context "when the current_user is an admin and owns the survey and it is published and not yet public" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :published, available_to_public: false, user_id: admin_user.id) }
      it "returns true" do
        is_expected.to eq(true)
      end
    end

    context "when the current_user is an admin but does not own the survey and the survey is not yet public" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :published, available_to_public: false, user_id: other_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end

    context "when the current_user is an admin and owns the survey but it is already public" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :published, available_to_public: true, user_id: admin_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end

    context "when the current_user is an admin and owns the survey but it is not published" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :draft, available_to_public: false, user_id: admin_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end

    context "when the current_user is not an admin" do
      let(:current_user) { other_user }
      let(:record) { build_stubbed(:survey, status: :published, available_to_public: false, user_id: other_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end
  end

  describe "#make_private?" do
    subject { policy.apply(:make_private?) }

    context "when the current_user is an admin and owns the survey and it is published and currently public" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :published, available_to_public: true, user_id: admin_user.id) }
      it "returns true" do
        is_expected.to eq(true)
      end
    end

    context "when the current_user is an admin and does not own the survey but the survey is public and published" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :published, available_to_public: true, user_id: other_user.id) }
      it "returns true" do
        is_expected.to eq(true)
      end
    end

    context "when the current_user is an admin and owns the survey but it is not public" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :published, available_to_public: false, user_id: admin_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end

    context "when the current_user is an admin and owns the survey but it is not published" do
      let(:current_user) { admin_user }
      let(:record) { build_stubbed(:survey, status: :draft, available_to_public: true, user_id: admin_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end

    context "when the current_user is not an admin" do
      let(:current_user) { other_user }
      let(:record) { build_stubbed(:survey, status: :published, available_to_public: true, user_id: other_user.id) }
      it "returns false" do
        is_expected.to eq(false)
      end
    end
  end
end
