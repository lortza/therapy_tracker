# frozen_string_literal: true

require "rails_helper"

RSpec.describe "PtSessionLogs", type: :request do
  let!(:user) { create(:user) }
  let!(:pt_session_log) {
    create(:pt_session_log,
      user_id: user.id,
      body_part_id: create(:body_part).id)
  }

  describe "Public access to pt_session_logs" do
    it "denies access to pt_session_logs#new" do
      get new_pt_session_log_path
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to pt_session_logs#show" do
      get pt_session_log_path(pt_session_log.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to pt_session_logs#edit" do
      get edit_pt_session_log_path(pt_session_log.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to pt_session_logs#create" do
      pt_session_log_attributes = build(:pt_session_log, user_id: user.id).attributes

      expect {
        post pt_session_logs_path(pt_session_log_attributes)
      }.to_not change(PtSessionLog, :count)

      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to pt_session_logs#update" do
      patch pt_session_log_path(pt_session_log, pt_session_log: pt_session_log.attributes)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to pt_session_logs#destroy" do
      delete pt_session_log_path(pt_session_log)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "Authenticated access to pt_session_logs" do
    it "renders pt_session_logs#new" do
      sign_in(user)
      get new_pt_session_log_path

      expect(response).to be_successful
      expect(response).to render_template(:new)
    end

    it "renders pt_session_logs#show" do
      sign_in(user)
      get pt_session_log_path(pt_session_log.id)

      expect(response).to be_successful
      expect(response.body).to include(pt_session_log.homework)
    end

    it "renders pt_session_logs#edit" do
      sign_in(user)
      get edit_pt_session_log_path(pt_session_log.id)

      expect(response).to be_successful
      expect(response).to render_template(:edit)
      expect(response.body).to include(pt_session_log.homework)
    end

    it "renders pt_session_logs#create" do
      sign_in(user)
      pt_session_log_attributes = build(:pt_session_log,
        user_id: user.id,
        body_part_id: create(:body_part).id).attributes

      expect {
        post pt_session_logs_path(pt_session_log: pt_session_log_attributes)
      }.to change(PtSessionLog, :count)

      expect(response).to redirect_to root_url
    end

    it "renders pt_session_logs#update" do
      sign_in(user)
      new_homework = "completely different homework level"
      patch pt_session_log_path(pt_session_log, pt_session_log: {body_part_id: new_homework})

      expect(response).to be_successful
    end

    it "renders pt_session_logs#destroy" do
      sign_in(user)

      expect {
        delete pt_session_log_path(pt_session_log)
      }.to change(PtSessionLog, :count)

      expect(response).to redirect_to root_url
    end
  end
end
