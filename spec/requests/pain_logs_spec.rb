# frozen_string_literal: true

require "rails_helper"

RSpec.describe "PainLogs", type: :request do
  let!(:user) { create(:user) }
  let!(:pain_log) {
    create(:pain_log,
      user_id: user.id,
      body_part_id: create(:body_part).id,
      pain_id: create(:pain).id)
  }

  describe "Public access to pain_logs" do
    it "denies access to pain_logs#new" do
      get new_pain_log_path
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to pain_logs#show" do
      get pain_log_path(pain_log.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to pain_logs#edit" do
      get edit_pain_log_path(pain_log.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to pain_logs#create" do
      pain_log_attributes = build(:pain_log, user_id: user.id).attributes

      expect {
        post pain_logs_path(pain_log_attributes)
      }.to_not change(PainLog, :count)

      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to pain_logs#update" do
      patch pain_log_path(pain_log, pain_log: pain_log.attributes)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to pain_logs#destroy" do
      delete pain_log_path(pain_log)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "Authenticated access to pain_logs" do
    it "renders pain_logs#new" do
      sign_in(user)
      get new_pain_log_path

      expect(response).to be_successful
      expect(response).to render_template(:new)
    end

    it "renders pain_logs#show" do
      sign_in(user)
      get pain_log_path(pain_log.id)

      expect(response).to be_successful
      expect(response.body).to include(pain_log.pain_description)
    end

    it "renders pain_logs#edit" do
      sign_in(user)
      get edit_pain_log_path(pain_log.id)

      expect(response).to be_successful
      expect(response).to render_template(:edit)
      expect(response.body).to include(pain_log.pain_description)
    end

    it "renders pain_logs#create" do
      sign_in(user)
      pain_log_attributes = build(:pain_log,
        user_id: user.id,
        body_part_id: create(:body_part).id,
        pain_id: create(:pain).id).attributes

      expect {
        post pain_logs_path(pain_log: pain_log_attributes)
      }.to change(PainLog, :count)

      expect(response).to redirect_to root_url
    end

    it "renders pain_logs#update" do
      sign_in(user)
      new_pain_description = "completely different pain_description"
      patch pain_log_path(pain_log, pain_log: {body_part_id: new_pain_description})

      expect(response).to be_successful
    end

    it "renders pain_logs#destroy" do
      sign_in(user)

      expect {
        delete pain_log_path(pain_log)
      }.to change(PainLog, :count)

      expect(response).to redirect_to root_url
    end
  end
end
