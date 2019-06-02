# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'BodyParts', type: :request do
  let!(:user) { create(:user) }
  let!(:body_part) { create(:body_part, user_id: user.id) }

  describe 'Public access to body_parts' do
    it 'denies access to body_parts#new' do
      get new_body_part_path
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to body_parts#edit' do
      get edit_body_part_path(body_part.id)
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to body_parts#create' do
      body_part_attributes = build(:body_part, user_id: user.id).attributes

      expect {
        post body_parts_path(body_part_attributes)
      }.to_not change(BodyPart, :count)

      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to body_parts#update' do
      patch body_part_path(body_part, body_part: body_part.attributes)
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to body_parts#destroy' do
      delete body_part_path(body_part)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'Authenticated access to body_parts' do
    it 'renders body_parts#new' do
      sign_in(user)
      get new_body_part_path

      expect(response).to be_successful
      expect(response).to render_template(:new)
    end

    it 'renders body_parts#edit' do
      sign_in(user)
      get edit_body_part_path(body_part.id)

      expect(response).to be_successful
      expect(response).to render_template(:edit)
      expect(response.body).to include(body_part.name)
    end

    it 'renders body_parts#create' do
      sign_in(user)
      body_part_attributes = build(:body_part, user_id: user.id).attributes

      expect {
        post body_parts_path(body_part: body_part_attributes)
      }.to change(BodyPart, :count)

      expect(response).to redirect_to body_parts_url
    end

    it 'renders body_parts#update' do
      sign_in(user)
      new_name = 'completely different name'
      patch body_part_path(body_part, body_part: { name: new_name })

      expect(response).to redirect_to body_parts_url
    end

    it 'renders body_parts#destroy' do
      sign_in(user)
      delete body_part_path(body_part)

      expect(response).to redirect_to body_parts_url
      expect(response.body).to_not include(body_part.name)
    end
  end
end
