# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PainLogQuickFormValues', type: :request do
  let!(:user) { create(:user) }
  let!(:pain_log_quick_form_value) { create(:pain_log_quick_form_value, user_id: user.id) }

  describe 'Public access to pain_log_quick_form_values' do
    it 'denies access to pain_log_quick_form_values#new' do
      get new_pain_log_quick_form_value_path
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to pain_log_quick_form_values#edit' do
      get edit_pain_log_quick_form_value_path(pain_log_quick_form_value.id)
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to pain_log_quick_form_values#create' do
      pain_log_quick_form_value_attributes = build(:pain_log_quick_form_value, user_id: user.id).attributes

      expect {
        post pain_log_quick_form_values_path(pain_log_quick_form_value_attributes)
      }.to_not change(PainLogQuickFormValue, :count)

      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to pain_log_quick_form_values#update' do
      patch pain_log_quick_form_value_path(pain_log_quick_form_value, pain_log_quick_form_value: pain_log_quick_form_value.attributes)
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to pain_log_quick_form_values#destroy' do
      delete pain_log_quick_form_value_path(pain_log_quick_form_value)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'Authenticated access to pain_log_quick_form_values' do
    it 'renders pain_log_quick_form_values#new' do
      sign_in(user)
      get new_pain_log_quick_form_value_path

      expect(response).to be_successful
      expect(response).to render_template(:new)
    end

    it 'renders pain_log_quick_form_values#edit' do
      sign_in(user)
      get edit_pain_log_quick_form_value_path(pain_log_quick_form_value.id)

      expect(response).to be_successful
      expect(response).to render_template(:edit)
      expect(response.body).to include(pain_log_quick_form_value.name)
    end

    it 'renders pain_log_quick_form_values#create' do
      sign_in(user)
      body_part = create(:body_part)
      pain = create(:pain)
      pain_log_quick_form_value_attributes = build(:pain_log_quick_form_value,
                                                   pain_level: 1,
                                                   pain_id: pain.id,
                                                   body_part_id: body_part.id,
                                                   user_id: user.id).attributes

      expect {
        post pain_log_quick_form_values_path(pain_log_quick_form_value: pain_log_quick_form_value_attributes)
      }.to change(PainLogQuickFormValue, :count)

      expect(response).to redirect_to pain_log_quick_form_values_url
    end

    it 'renders pain_log_quick_form_values#update' do
      sign_in(user)
      new_name = 'completely different name'
      patch pain_log_quick_form_value_path(pain_log_quick_form_value, pain_log_quick_form_value: { name: new_name })

      expect(response).to redirect_to pain_log_quick_form_values_url
    end

    it 'renders pain_log_quick_form_values#destroy' do
      sign_in(user)
      delete pain_log_quick_form_value_path(pain_log_quick_form_value)

      expect(response).to redirect_to pain_log_quick_form_values_url
      expect(response.body).to_not include(pain_log_quick_form_value.name)
    end
  end
end
