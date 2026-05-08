# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Surveys", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe "unauthenticated access" do
    it "redirects index to sign in" do
      get surveys_path
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "authenticated access" do
    before { sign_in(user) }

    describe "index: GET /surveys" do
      it "renders successfully" do
        get surveys_path
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end

      it "includes the current user's published surveys" do
        own_published = create(:survey, status: :published, user_id: user.id)

        get surveys_path

        expect(assigns(:surveys)).to include(own_published)
      end

      it "includes the current user's published surveys that are also public" do
        own_published_public = create(:survey, status: :published, available_to_public: true, user_id: user.id)

        get surveys_path

        expect(assigns(:surveys)).to include(own_published_public)
      end

      it "includes other users' published public surveys" do
        other_published_public = create(:survey, status: :published, available_to_public: true, user_id: other_user.id)

        get surveys_path

        expect(assigns(:surveys)).to include(other_published_public)
      end

      it "excludes the current user's draft surveys" do
        own_draft = create(:survey, status: :draft, user_id: user.id)

        get surveys_path

        expect(assigns(:surveys)).not_to include(own_draft)
      end

      it "excludes the current user's archived surveys" do
        own_archived = create(:survey, status: :archived, user_id: user.id)

        get surveys_path

        expect(assigns(:surveys)).not_to include(own_archived)
      end

      it "excludes other users' published non-public surveys" do
        other_published_private = create(:survey, status: :published, available_to_public: false, user_id: other_user.id)

        get surveys_path

        expect(assigns(:surveys)).not_to include(other_published_private)
      end

      it "excludes other users' draft public surveys" do
        other_draft_public = create(:survey, status: :draft, available_to_public: true, user_id: other_user.id)

        get surveys_path

        expect(assigns(:surveys)).not_to include(other_draft_public)
      end

      it "excludes other users' archived public surveys" do
        other_archived_public = create(:survey, status: :archived, available_to_public: true, user_id: other_user.id)

        get surveys_path

        expect(assigns(:surveys)).not_to include(other_archived_public)
      end
    end
  end
end
