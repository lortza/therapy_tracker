# frozen_string_literal: true

require "rails_helper"

RSpec.describe SlitLogsController, type: :request do
  let(:user) { create(:user) }
  let(:slit_log) { create(:slit_log, user_id: user.id, occurred_at: Time.current) }

  describe "Public access to slit_logs" do
    it "denies access to slit_logs#new" do
      get new_slit_log_path
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to slit_logs#edit" do
      get edit_slit_log_path(slit_log.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to slit_logs#create" do
      slit_log_attributes = build(:slit_log, user_id: user.id, occurred_at: Time.current).attributes

      expect {
        post slit_logs_path(slit_log_attributes)
      }.to_not change(SlitLog, :count)

      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to slit_logs#quick_log_create" do
      expect {
        post quick_log_create_path
      }.to_not change(SlitLog, :count)

      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to slit_logs#update" do
      patch slit_log_path(slit_log, slit_log: slit_log.attributes)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to slit_logs#destroy" do
      delete slit_log_path(slit_log)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "Authenticated access to slit_logs" do
    before { sign_in(user) }
    it "renders slit_logs#new" do
      get new_slit_log_path

      expect(response).to be_successful
      expect(response).to render_template(:new)
    end

    it "renders slit_logs#edit" do
      get edit_slit_log_path(slit_log.id)

      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end

    it "renders slit_logs#create" do
      slit_log_attributes = build(
        :slit_log,
        user_id: user.id,
        occurred_at: Time.current,
        started_new_bottle: true,
        doses_remaining: 5
      ).attributes

      expect {
        post slit_logs_path(slit_log: slit_log_attributes)
      }.to change(SlitLog, :count)

      expect(response).to redirect_to root_url
    end

    it "renders slit_logs#quick_log_create" do
      expect {
        post quick_log_create_path
      }.to change(SlitLog, :count)

      expect(response).to redirect_to root_url
    end

    it "renders slit_logs#update" do
      new_datetime = 4.days.ago
      patch slit_log_path(slit_log, slit_log: {occurred_at: new_datetime})

      expect(response).to redirect_to root_url
    end

    it "renders slit_logs#destroy" do
      delete slit_log_path(slit_log)

      expect(response).to redirect_to root_url
      expect(response.body).to_not include(slit_log.id.to_s)
    end

    it "renders delete link with correct turbo attributes in edit page" do
      get edit_slit_log_path(slit_log)

      expect(response).to be_successful
      expect(response.body).to include("data-turbo-method=\"delete\"")
      expect(response.body).to include("data-turbo-confirm")
      expect(response.body).to include("Click to delete")
    end

    it "actually deletes the slit log via DELETE request" do
      # Ensure slit_log exists before the expect block
      log_id = slit_log.id
      expect(SlitLog.find_by(id: log_id)).to be_present

      expect {
        delete slit_log_path(slit_log)
      }.to change(SlitLog, :count).by(-1)

      expect(response).to redirect_to root_url
      expect(SlitLog.find_by(id: log_id)).to be_nil
    end

    it "does not delete slit log with GET request to same path" do
      # Ensure slit_log exists before the test
      log_id = slit_log.id
      expect(SlitLog.find_by(id: log_id)).to be_present

      # This should NOT delete - SLIT logs don't have a show action, so it should error
      expect {
        get slit_log_path(slit_log)
      }.not_to change(SlitLog, :count)

      # Should get an error since there's no show action
      expect(response).not_to be_successful
      expect(SlitLog.find_by(id: log_id)).to be_present
    end
  end
end
