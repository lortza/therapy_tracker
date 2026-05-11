# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Survey::Responses", type: :request do
  let(:user) { create(:user, admin: true) }
  let(:other_user) { create(:user, admin: true) }
  let(:non_admin) { create(:user, admin: false) }
  let(:survey) { create(:survey, status: :published) }
  let(:survey_category) { create(:survey_category, survey: survey) }
  let!(:question_one) { create(:survey_question, category: survey_category) }
  let!(:question_two) { create(:survey_question, category: survey_category) }
  let!(:answer_option) { create(:survey_answer_option, survey: survey, value: 2) }
  let!(:score_range_step) do
    create(:survey_score_range_step, survey: survey, calculated_range_min_points: 0, calculated_range_max_points: 100)
  end

  describe "unauthenticated access" do
    it "redirects index to sign in" do
      get survey_responses_path(survey)
      expect(response).to redirect_to new_user_session_path
    end

    it "redirects new to sign in" do
      get new_survey_response_path(survey)
      expect(response).to redirect_to new_user_session_path
    end

    it "redirects create to sign in" do
      post survey_responses_path(survey), params: {survey_response: {notes: "x"}}
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "non-admin access" do
    before { sign_in(non_admin) }

    # The feature is currently admin-only via Survey::ResponsePolicy.
    # When access is broadened, flip these expectations to match the new policy.
    it "denies index" do
      expect {
        get survey_responses_path(survey)
      }.to raise_error(ActionPolicy::Unauthorized)
    end

    it "denies new" do
      expect {
        get new_survey_response_path(survey)
      }.to raise_error(ActionPolicy::Unauthorized)
    end

    it "denies create and does not persist a response" do
      expect {
        expect {
          post survey_responses_path(survey), params: {survey_response: {notes: "x"}}
        }.to raise_error(ActionPolicy::Unauthorized)
      }.not_to change(Survey::Response, :count)
    end
  end

  describe "admin access" do
    before { sign_in(user) }

    describe "index: GET /surveys/:survey_id/responses" do
      it "renders successfully" do
        get survey_responses_path(survey)
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end

      it "assigns the current user's responses for the given survey" do
        own_response = create(:survey_response, user: user, survey: survey)

        get survey_responses_path(survey)

        expect(assigns(:survey_responses)).to include(own_response)
      end

      it "excludes responses belonging to other users" do
        other_response = create(:survey_response, user: other_user, survey: survey)

        get survey_responses_path(survey)

        expect(assigns(:survey_responses)).not_to include(other_response)
      end

      it "excludes responses for other surveys" do
        other_survey = create(:survey, status: :published)
        unrelated_response = create(:survey_response, user: user, survey: other_survey)

        get survey_responses_path(survey)

        expect(assigns(:survey_responses)).not_to include(unrelated_response)
      end

      it "orders responses by occurred_at descending" do
        older = create(:survey_response, user: user, survey: survey, occurred_at: 3.days.ago)
        newer = create(:survey_response, user: user, survey: survey, occurred_at: 1.day.ago)

        get survey_responses_path(survey)

        expect(assigns(:survey_responses).to_a).to eq([newer, older])
      end
    end

    describe "new: GET /surveys/:survey_id/responses/new" do
      it "renders successfully" do
        get new_survey_response_path(survey)
        expect(response).to be_successful
        expect(response).to render_template(:new)
      end

      it "builds an unpersisted response with one answer per question" do
        get new_survey_response_path(survey)

        expect(assigns(:survey_response)).to be_a_new(Survey::Response)
        expect(assigns(:survey_response).answers.size).to eq(survey.questions.size)
        expect(assigns(:survey_response).answers.map(&:question)).to match_array(survey.questions.to_a)
      end
    end

    describe "create: POST /surveys/:survey_id/responses" do
      let(:occurred_at) { Time.zone.local(2026, 5, 1, 9, 30) }
      let(:valid_params) do
        {
          survey_response: {
            notes: "feeling better today",
            occurred_at: occurred_at,
            answers_attributes: [
              {survey_question_id: question_one.id, survey_answer_option_id: answer_option.id},
              {survey_question_id: question_two.id, survey_answer_option_id: answer_option.id}
            ]
          }
        }
      end

      context "with valid params" do
        it "creates a survey response scoped to the current user" do
          expect {
            post survey_responses_path(survey), params: valid_params
          }.to change(Survey::Response, :count).by(1)

          expect(Survey::Response.last.user).to eq(user)
          expect(Survey::Response.last.survey).to eq(survey)
        end

        it "creates an answer per submitted question" do
          expect {
            post survey_responses_path(survey), params: valid_params
          }.to change(Survey::Answer, :count).by(2)
        end

        it "persists the submitted occurred_at" do
          post survey_responses_path(survey), params: valid_params

          expect(Survey::Response.last.occurred_at).to be_within(1.second).of(occurred_at)
        end

        it "redirects to the responses index with a notice" do
          post survey_responses_path(survey), params: valid_params

          expect(response).to redirect_to(survey_responses_path(survey))
          expect(flash[:notice]).to eq("Response submitted successfully.")
        end
      end

      context "when the response cannot be saved" do
        before { allow_any_instance_of(Survey::Response).to receive(:save).and_return(false) }

        it "does not create a survey response" do
          expect {
            post survey_responses_path(survey), params: valid_params
          }.not_to change(Survey::Response, :count)
        end

        it "re-renders new with unprocessable_content status" do
          post survey_responses_path(survey), params: valid_params

          expect(response).to have_http_status(:unprocessable_content)
          expect(response).to render_template(:new)
        end
      end
    end
  end
end
