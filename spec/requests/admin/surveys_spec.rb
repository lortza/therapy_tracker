# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Admin::Surveys", type: :request do
  let(:admin) { create(:user, admin: true) }
  let(:survey) { create(:survey) }

  describe "unauthenticated access" do
    it "redirects index to sign in" do
      get admin_surveys_path
      expect(response).to redirect_to new_user_session_path
    end

    it "redirects show to sign in" do
      get admin_survey_path(survey)
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

    # it "redirects new to root" do
    #   get new_admin_survey_path
    #   expect(response).to redirect_to root_path
    # end
  end

  describe "admin access" do
    before { sign_in(admin) }

    describe "GET /admin/surveys" do
      it "renders successfully" do
        get admin_surveys_path
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end
    end

    describe "GET /admin/surveys/:id" do
      it "renders successfully" do
        get admin_survey_path(survey)
        expect(response).to be_successful
        expect(response).to render_template(:show)
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

    # describe "PATCH /admin/surveys/:id" do
    #   context "with valid params" do
    #     it "updates the survey and redirects to show" do
    #       patch admin_survey_path(survey), params: {survey: {name: "Updated Name"}}

    #       expect(survey.reload.name).to eq("Updated Name")
    #       expect(response).to redirect_to admin_survey_path(survey)
    #     end
    #   end

    #   context "with invalid params" do
    #     it "does not update the survey and re-renders edit" do
    #       original_name = survey.name
    #       patch admin_survey_path(survey), params: {survey: {name: ""}}

    #       expect(survey.reload.name).to eq(original_name)
    #       expect(response).to render_template(:edit)
    #     end
    #   end
    # end

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
