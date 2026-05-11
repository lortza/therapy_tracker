# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Admin::Survey::Questions", type: :request do
  let(:admin) { create(:user, admin: true) }
  let(:survey) { create(:survey, status: :draft, user_id: admin.id) }
  let(:category) { create(:survey_category, survey: survey) }
  let(:question) { create(:survey_question, category: category) }

  # new and edit only respond to turbo_stream, so requests must include the Accept header
  let(:turbo_stream_headers) { {"Accept" => "text/vnd.turbo-stream.html"} }

  describe "unauthenticated access" do
    it "redirects new to sign in" do
      get new_admin_survey_category_question_path(survey, category), headers: turbo_stream_headers
      expect(response).to redirect_to new_user_session_path
    end

    it "redirects create to sign in" do
      post admin_survey_category_questions_path(survey, category), params: {survey_question: {text: "How often do you feel hopeless?", position: 0}}
      expect(response).to redirect_to new_user_session_path
    end

    it "redirects edit to sign in" do
      get edit_admin_survey_category_question_path(survey, category, question), headers: turbo_stream_headers
      expect(response).to redirect_to new_user_session_path
    end

    it "redirects update to sign in" do
      patch admin_survey_category_question_path(survey, category, question), params: {survey_question: {text: "Updated text"}}
      expect(response).to redirect_to new_user_session_path
    end

    it "redirects destroy to sign in" do
      delete admin_survey_category_question_path(survey, category, question)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "non-admin access" do
    let(:non_admin) { create(:user, admin: false) }

    before { sign_in(non_admin) }

    it "redirects new to root" do
      get new_admin_survey_category_question_path(survey, category), headers: turbo_stream_headers
      expect(response).to redirect_to root_path
    end

    it "redirects create to root" do
      post admin_survey_category_questions_path(survey, category), params: {survey_question: {text: "How often do you feel hopeless?", position: 0}}
      expect(response).to redirect_to root_path
    end

    it "redirects edit to root" do
      get edit_admin_survey_category_question_path(survey, category, question), headers: turbo_stream_headers
      expect(response).to redirect_to root_path
    end

    it "redirects update to root" do
      patch admin_survey_category_question_path(survey, category, question), params: {survey_question: {text: "Updated text"}}
      expect(response).to redirect_to root_path
    end

    it "redirects destroy to root" do
      delete admin_survey_category_question_path(survey, category, question)
      expect(response).to redirect_to root_path
    end
  end

  describe "admin access" do
    before { sign_in(admin) }

    describe "GET new" do
      it "renders successfully" do
        get new_admin_survey_category_question_path(survey, category), headers: turbo_stream_headers
        expect(response).to be_successful
      end
    end

    describe "POST create" do
      context "with valid params" do
        it "creates the question and redirects to the survey" do
          expect {
            post admin_survey_category_questions_path(survey, category), params: {survey_question: {text: "How often do you feel hopeless?", position: 0}}
          }.to change(Survey::Question, :count).by(1)

          expect(response).to redirect_to admin_survey_path(survey)
        end
      end

      context "with invalid params" do
        it "does not create the question" do
          expect {
            post admin_survey_category_questions_path(survey, category),
              params: {survey_question: {text: "", position: 0}},
              headers: turbo_stream_headers
          }.not_to change(Survey::Question, :count)
        end
      end
    end

    describe "GET edit" do
      it "renders successfully" do
        get edit_admin_survey_category_question_path(survey, category, question), headers: turbo_stream_headers
        expect(response).to be_successful
      end
    end

    describe "PATCH update" do
      context "with valid params" do
        it "updates the question and redirects to the survey" do
          patch admin_survey_category_question_path(survey, category, question), params: {survey_question: {text: "Updated text"}}

          expect(question.reload.text).to eq("Updated text")
          expect(response).to redirect_to admin_survey_path(survey)
        end
      end

      context "with invalid params" do
        it "does not update the question" do
          original_text = question.text
          patch admin_survey_category_question_path(survey, category, question),
            params: {survey_question: {text: ""}},
            headers: turbo_stream_headers

          expect(question.reload.text).to eq(original_text)
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the question and redirects to the survey" do
        question_to_delete = create(:survey_question, category: category)

        expect {
          delete admin_survey_category_question_path(survey, category, question_to_delete)
        }.to change(Survey::Question, :count).by(-1)

        expect(response).to redirect_to admin_survey_path(survey)
      end
    end
  end
end
