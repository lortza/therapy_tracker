# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Admin::Survey::AnswerOptions", type: :request do
  let(:admin) { create(:user, admin: true) }
  let(:survey) { create(:survey, status: :draft, user_id: admin.id) }
  let(:answer_option) { create(:survey_answer_option, survey: survey) }

  # new and edit only respond to turbo_stream, so requests must include the Accept header
  let(:turbo_stream_headers) { {"Accept" => "text/vnd.turbo-stream.html"} }

  describe "unauthenticated access" do
    it "redirects new to sign in" do
      get new_admin_survey_answer_option_path(survey), headers: turbo_stream_headers
      expect(response).to redirect_to new_user_session_path
    end

    it "redirects create to sign in" do
      post admin_survey_answer_options_path(survey), params: {survey_answer_option: {name: "Option", value: 1, survey_id: survey.id}}
      expect(response).to redirect_to new_user_session_path
    end

    it "redirects edit to sign in" do
      get edit_admin_survey_answer_option_path(survey, answer_option), headers: turbo_stream_headers
      expect(response).to redirect_to new_user_session_path
    end

    it "redirects update to sign in" do
      patch admin_survey_answer_option_path(survey, answer_option), params: {survey_answer_option: {name: "Updated"}}
      expect(response).to redirect_to new_user_session_path
    end

    it "redirects destroy to sign in" do
      delete admin_survey_answer_option_path(survey, answer_option)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "non-admin access" do
    let(:non_admin) { create(:user, admin: false) }

    before { sign_in(non_admin) }

    it "redirects new to root" do
      get new_admin_survey_answer_option_path(survey), headers: turbo_stream_headers
      expect(response).to redirect_to root_path
    end

    it "redirects create to root" do
      post admin_survey_answer_options_path(survey), params: {survey_answer_option: {name: "Option", value: 1, survey_id: survey.id}}
      expect(response).to redirect_to root_path
    end

    it "redirects edit to root" do
      get edit_admin_survey_answer_option_path(survey, answer_option), headers: turbo_stream_headers
      expect(response).to redirect_to root_path
    end

    it "redirects update to root" do
      patch admin_survey_answer_option_path(survey, answer_option), params: {survey_answer_option: {name: "Updated"}}
      expect(response).to redirect_to root_path
    end

    it "redirects destroy to root" do
      delete admin_survey_answer_option_path(survey, answer_option)
      expect(response).to redirect_to root_path
    end
  end

  describe "admin access" do
    before { sign_in(admin) }

    describe "GET new" do
      it "renders successfully" do
        get new_admin_survey_answer_option_path(survey), headers: turbo_stream_headers
        expect(response).to be_successful
      end
    end

    describe "POST create" do
      context "with valid params" do
        it "creates the answer option and redirects to the survey" do
          expect {
            post admin_survey_answer_options_path(survey), params: {survey_answer_option: {name: "Mild", value: 1, survey_id: survey.id}}
          }.to change(Survey::AnswerOption, :count).by(1)

          expect(response).to redirect_to admin_survey_path(survey)
        end
      end

      context "with invalid params" do
        it "does not create the answer option" do
          expect {
            post admin_survey_answer_options_path(survey), params: {survey_answer_option: {name: "", value: nil, survey_id: survey.id}}
          }.not_to change(Survey::AnswerOption, :count)
        end
      end
    end

    describe "GET edit" do
      it "renders successfully" do
        get edit_admin_survey_answer_option_path(survey, answer_option), headers: turbo_stream_headers
        expect(response).to be_successful
      end
    end

    describe "PATCH update" do
      context "with valid params" do
        it "updates the answer option and redirects to the survey" do
          patch admin_survey_answer_option_path(survey, answer_option), params: {survey_answer_option: {name: "Updated Name"}}

          expect(answer_option.reload.name).to eq("Updated Name")
          expect(response).to redirect_to admin_survey_path(survey)
        end
      end

      context "with invalid params" do
        it "does not update the answer option" do
          original_name = answer_option.name
          patch admin_survey_answer_option_path(survey, answer_option), params: {survey_answer_option: {name: ""}}

          expect(answer_option.reload.name).to eq(original_name)
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the answer option and redirects to the survey" do
        answer_option_to_delete = create(:survey_answer_option, survey: survey)

        expect {
          delete admin_survey_answer_option_path(survey, answer_option_to_delete)
        }.to change(Survey::AnswerOption, :count).by(-1)

        expect(response).to redirect_to admin_survey_path(survey)
      end
    end
  end
end
