# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Admin::Surveys", type: :request do
  let(:admin) { create(:user, admin: true) }
  let(:survey) { create(:survey, user_id: admin.id) }

  describe "unauthenticated access" do
    it "redirects index to sign in" do
      get admin_surveys_path
      expect(response).to redirect_to new_user_session_path
    end

    it "redirects show to sign in" do
      get admin_survey_path(survey)
      expect(response).to redirect_to new_user_session_path
    end

    it "redirects publish to sign in" do
      post publish_admin_survey_path(survey)
      expect(response).to redirect_to new_user_session_path
    end

    it "redirects archive to sign in" do
      post archive_admin_survey_path(survey)
      expect(response).to redirect_to new_user_session_path
    end

    it "redirects make_public to sign in" do
      post make_public_admin_survey_path(survey)
      expect(response).to redirect_to new_user_session_path
    end

    it "redirects make_private to sign in" do
      post make_private_admin_survey_path(survey)
      expect(response).to redirect_to new_user_session_path
    end

    it "redirects destroy to sign in" do
      delete admin_survey_path(survey)
      expect(response).to redirect_to new_user_session_path
    end

    # it "redirects new to sign in" do
    #   get new_admin_survey_path
    #   expect(response).to redirect_to new_user_session_path
    # end

    # it "redirects create to sign in" do
    #   post admin_surveys_path, params: {survey: {name: "New Survey"}}
    #   expect(response).to redirect_to new_user_session_path
    # end

    # it "redirects edit to sign in" do
    #   get edit_admin_survey_path(survey)
    #   expect(response).to redirect_to new_user_session_path
    # end

    # it "redirects update to sign in" do
    #   patch admin_survey_path(survey), params: {survey: {name: "Updated"}}
    #   expect(response).to redirect_to new_user_session_path
    # end

    # it "redirects destroy to sign in" do
    #   delete admin_survey_path(survey)
    #   expect(response).to redirect_to new_user_session_path
    # end
  end

  describe "non-admin access" do
    let(:non_admin) { create(:user, admin: false) }

    before { sign_in(non_admin) }

    it "redirects index to root" do
      get admin_surveys_path
      expect(response).to redirect_to root_path
    end

    it "redirects show to root" do
      get admin_survey_path(survey)
      expect(response).to redirect_to root_path
    end

    it "redirects publish to root" do
      post publish_admin_survey_path(survey)
      expect(response).to redirect_to root_path
    end

    it "redirects archive to root" do
      post archive_admin_survey_path(survey)
      expect(response).to redirect_to root_path
    end

    it "redirects make_public to root" do
      post make_public_admin_survey_path(survey)
      expect(response).to redirect_to root_path
    end

    it "redirects make_private to root" do
      post make_private_admin_survey_path(survey)
      expect(response).to redirect_to root_path
    end

    it "redirects destroy to root" do
      delete admin_survey_path(survey)
      expect(response).to redirect_to root_path
    end
  end

  describe "admin access" do
    before { sign_in(admin) }

    describe "index: GET /admin/surveys" do
      it "renders successfully" do
        get admin_surveys_path
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end
    end

    describe "show: GET /admin/surveys/:id" do
      it "renders successfully when the admin owns the survey" do
        get admin_survey_path(survey)
        expect(response).to be_successful
        expect(response).to render_template(:show)
      end

      it "renders successfully when the survey is public" do
        public_survey = create(:survey, available_to_public: true)
        get admin_survey_path(public_survey)
        expect(response).to be_successful
        expect(response).to render_template(:show)
      end
    end

    describe "publish: POST /admin/surveys/:id/publish" do
      it "publishes a draft survey owned by the admin and redirects to show" do
        draft_survey = create(:survey, status: :draft, user_id: admin.id)
        post publish_admin_survey_path(draft_survey)

        expect(draft_survey.reload).to be_published
        expect(response).to redirect_to admin_survey_path(draft_survey)
      end
    end

    describe "archive: POST /admin/surveys/:id/archive" do
      it "archives a published survey owned by the admin and redirects to show" do
        published_survey = create(:survey, status: :published, user_id: admin.id)
        post archive_admin_survey_path(published_survey)

        expect(published_survey.reload).to be_archived
        expect(response).to redirect_to admin_survey_path(published_survey)
      end
    end

    describe "make_public: POST /admin/surveys/:id/make_public" do
      it "makes a published survey public and redirects to show" do
        published_survey = create(:survey, status: :published, available_to_public: false, user_id: admin.id)
        post make_public_admin_survey_path(published_survey)

        expect(published_survey.reload.available_to_public).to be true
        expect(response).to redirect_to admin_survey_path(published_survey)
      end
    end

    describe "make_private: POST /admin/surveys/:id/make_private" do
      it "makes a public survey private and redirects to show" do
        public_survey = create(:survey, status: :published, available_to_public: true, user_id: admin.id)
        post make_private_admin_survey_path(public_survey)

        expect(public_survey.reload.available_to_public).to be false
        expect(response).to redirect_to admin_survey_path(public_survey)
      end
    end

    describe "DELETE /admin/surveys/:id" do
      it "destroys a draft survey owned by the admin and redirects to index" do
        draft_survey = create(:survey, status: :draft, user_id: admin.id)

        expect {
          delete admin_survey_path(draft_survey)
        }.to change(Survey, :count).by(-1)

        expect(response).to redirect_to admin_surveys_path
      end
    end

    # describe "GET /admin/surveys/new" do
    #   it "renders successfully" do
    #     get new_admin_survey_path
    #     expect(response).to be_successful
    #     expect(response).to render_template(:new)
    #   end
    # end

    # describe "POST /admin/surveys" do
    #   context "with valid params" do
    #     it "creates the survey and redirects to show" do
    #       expect {
    #         post admin_surveys_path, params: {survey: {name: "New Survey", description: "A description"}}
    #       }.to change(Survey, :count).by(1)

    #       expect(response).to redirect_to admin_survey_path(Survey.last)
    #     end
    #   end

    #   context "with invalid params" do
    #     it "does not create the survey and re-renders new" do
    #       expect {
    #         post admin_surveys_path, params: {survey: {name: ""}}
    #       }.not_to change(Survey, :count)

    #       expect(response).to render_template(:new)
    #     end
    #   end
    # end

    # describe "GET /admin/surveys/:id/edit" do
    #   context "when the survey is not published" do
    #     it "renders successfully" do
    #       get edit_admin_survey_path(survey)
    #       expect(response).to be_successful
    #       expect(response).to render_template(:edit)
    #     end
    #   end

    #   context "when the survey is published" do
    #     let(:survey) { create(:survey, published: true) }

    #     it "redirects to show with an alert" do
    #       get edit_admin_survey_path(survey)
    #       expect(response).to redirect_to admin_survey_path(survey)
    #       expect(flash[:alert]).to be_present
    #     end
    #   end
    # end

    describe "PATCH /admin/surveys/:id" do
      context "with valid params" do
        it "updates the survey and redirects to show" do
          patch admin_survey_path(survey), params: {survey: {name: "Updated Name"}}

          expect(survey.reload.name).to eq("Updated Name")
          expect(response).to redirect_to admin_survey_path(survey)
        end

        it "calls calculate_score_range_steps_points!" do
          expect_any_instance_of(Survey).to receive(:calculate_score_range_steps_points!)
          patch admin_survey_path(survey), params: {survey: {name: "Updated Name"}}
        end
      end

      context "with invalid params" do
        it "does not update the survey and re-renders edit" do
          original_name = survey.name
          patch admin_survey_path(survey), params: {survey: {name: ""}}

          expect(survey.reload.name).to eq(original_name)
          expect(response).to render_template(:edit)
        end
      end
    end

    # describe "DELETE /admin/surveys/:id" do
    #   it "destroys the survey and redirects to index" do
    #     survey_to_delete = create(:survey)

    #     expect {
    #       delete admin_survey_path(survey_to_delete)
    #     }.to change(Survey, :count).by(-1)

    #     expect(response).to redirect_to admin_surveys_path
    #   end
    # end
  end
end
