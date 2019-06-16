# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PtSessions', type: :request do
  let!(:user) { create(:user) }
  let!(:pt_session) {
    create(:pt_session,
           user_id: user.id,
           body_part_id: create(:body_part).id)
  }

  describe 'Public access to pt_sessions' do
    it 'denies access to pt_sessions#new' do
      get new_pt_session_path
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to pt_sessions#show' do
      get pt_session_path(pt_session.id)
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to pt_sessions#edit' do
      get edit_pt_session_path(pt_session.id)
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to pt_sessions#create' do
      pt_session_attributes = build(:pt_session, user_id: user.id).attributes

      expect {
        post pt_sessions_path(pt_session_attributes)
      }.to_not change(PtSession, :count)

      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to pt_sessions#update' do
      patch pt_session_path(pt_session, pt_session: pt_session.attributes)
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to pt_sessions#destroy' do
      delete pt_session_path(pt_session)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'Authenticated access to pt_sessions' do
    it 'renders pt_sessions#new' do
      sign_in(user)
      get new_pt_session_path

      expect(response).to be_successful
      expect(response).to render_template(:new)
    end

    it 'renders pt_sessions#show' do
      sign_in(user)
      get pt_session_path(pt_session.id)

      expect(response).to be_successful
      expect(response.body).to include(pt_session.homework)
    end

    it 'renders pt_sessions#edit' do
      sign_in(user)
      get edit_pt_session_path(pt_session.id)

      expect(response).to be_successful
      expect(response).to render_template(:edit)
      expect(response.body).to include(pt_session.homework)
    end

    it 'renders pt_sessions#create' do
      sign_in(user)
      pt_session_attributes = build(:pt_session,
                                    user_id: user.id,
                                    body_part_id: create(:body_part).id).attributes

      expect {
        post pt_sessions_path(pt_session: pt_session_attributes)
      }.to change(PtSession, :count)

      expect(response).to redirect_to root_url
    end

    it 'renders pt_sessions#update' do
      sign_in(user)
      new_homework = 'completely different homework level'
      patch pt_session_path(pt_session, pt_session: { body_part_id: new_homework })

      expect(response).to be_successful
    end

    it 'renders pt_sessions#destroy' do
      sign_in(user)

      expect {
        delete pt_session_path(pt_session)
      }.to change(PtSession, :count)

      expect(response).to redirect_to root_url
    end
  end
end
