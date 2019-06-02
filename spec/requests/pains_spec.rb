# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pains', type: :request do
  let!(:user) { create(:user) }
  let!(:pain) { create(:pain, user_id: user.id) }

  describe 'Public access to pains' do
    it 'denies access to pains#new' do
      get new_pain_path
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to pains#edit' do
      get edit_pain_path(pain.id)
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to pains#create' do
      pain_attributes = build(:pain, user_id: user.id).attributes

      expect {
        post pains_path(pain_attributes)
      }.to_not change(Pain, :count)

      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to pains#update' do
      patch pain_path(pain, pain: pain.attributes)
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to pains#destroy' do
      delete pain_path(pain)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'Authenticated access to pains' do
    it 'renders pains#new' do
      sign_in(user)
      get new_pain_path

      expect(response).to be_successful
      expect(response).to render_template(:new)
    end

    it 'renders pains#edit' do
      sign_in(user)
      get edit_pain_path(pain.id)

      expect(response).to be_successful
      expect(response).to render_template(:edit)
      expect(response.body).to include(pain.name)
    end

    it 'renders pains#create' do
      sign_in(user)
      pain_attributes = build(:pain, user_id: user.id).attributes

      expect {
        post pains_path(pain: pain_attributes)
      }.to change(Pain, :count)

      expect(response).to redirect_to pains_url
    end

    it 'renders pains#update' do
      sign_in(user)
      new_name = 'completely different name'
      patch pain_path(pain, pain: { name: new_name })

      expect(response).to redirect_to pains_url
    end

    it 'renders pains#destroy' do
      sign_in(user)
      delete pain_path(pain)

      expect(response).to redirect_to pains_url
      expect(response.body).to_not include(pain.name)
    end
  end
end
