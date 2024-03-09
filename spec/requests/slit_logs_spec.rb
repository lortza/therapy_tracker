# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SlitLogsController, type: :request do
  let(:user) { create(:user) }
  let(:slit_log) { create(:slit_log, user_id: user.id, datetime_occurred: Time.current) }

  describe 'Public access to slit_logs' do
    it 'denies access to slit_logs#new' do
      get new_slit_log_path
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to slit_logs#edit' do
      get edit_slit_log_path(slit_log.id)
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to slit_logs#create' do
      slit_log_attributes = build(:slit_log, user_id: user.id, datetime_occurred: Time.current).attributes

      expect {
        post slit_logs_path(slit_log_attributes)
      }.to_not change(SlitLog, :count)

      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to slit_logs#quick_log_create' do
      expect {
        post quick_log_create_path
      }.to_not change(SlitLog, :count)

      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to slit_logs#update' do
      patch slit_log_path(slit_log, slit_log: slit_log.attributes)
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to slit_logs#destroy' do
      delete slit_log_path(slit_log)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'Authenticated access to slit_logs' do
    before { sign_in(user) }
    it 'renders slit_logs#new' do
      get new_slit_log_path

      expect(response).to be_successful
      expect(response).to render_template(:new)
    end

    it 'renders slit_logs#edit' do
      get edit_slit_log_path(slit_log.id)

      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end

    it 'renders slit_logs#create' do
      slit_log_attributes = build(
        :slit_log,
        user_id: user.id,
        datetime_occurred: Time.current,
        started_new_bottle: true,
        doses_remaining: 5
      ).attributes

      expect {
        post slit_logs_path(slit_log: slit_log_attributes)
      }.to change(SlitLog, :count)

      expect(response).to redirect_to root_url
    end

    it 'renders slit_logs#quick_log_create' do
      expect {
        post quick_log_create_path
      }.to change(SlitLog, :count)

      expect(response).to redirect_to root_url
    end

    it 'renders slit_logs#update' do
      new_datetime = 4.days.ago
      patch slit_log_path(slit_log, slit_log: { datetime_occurred: new_datetime })

      expect(response).to redirect_to root_url
    end

    it 'renders slit_logs#destroy' do
      delete slit_log_path(slit_log)

      expect(response).to redirect_to root_url
      expect(response.body).to_not include(slit_log.id.to_s)
    end
  end
end
