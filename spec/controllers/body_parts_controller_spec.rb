# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BodyPartsController, type: :controller do
  login_user

  let(:valid_attributes) { build(:body_part, user_id: subject.current_user.id).attributes }
  let(:invalid_attributes) { build(:body_part, user_id: subject.current_user.id, name: '').attributes }

  describe 'GET #index' do
    it 'returns a success response' do
      BodyPart.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      body_part = BodyPart.create! valid_attributes
      get :edit, params: { id: body_part.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new BodyPart' do
        expect {
          post :create, params: { body_part: valid_attributes }
        }.to change(BodyPart, :count).by(1)
      end

      it 'redirects to the body parts index' do
        post :create, params: { body_part: valid_attributes }
        expect(response).to redirect_to(BodyPart)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the "new" template)' do
        post :create, params: { body_part: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { build(:body_part, user_id: subject.current_user.id, name: 'updated name').attributes }

      it 'updates the requested body_part' do
        body_part = BodyPart.create! valid_attributes
        put :update, params: { id: body_part.to_param, body_part: new_attributes }
        body_part.reload
        body_part.name == new_attributes[:name]
      end

      it 'redirects to the body_part index' do
        body_part = BodyPart.create! valid_attributes
        put :update, params: { id: body_part.to_param, body_part: valid_attributes }
        expect(response).to redirect_to(BodyPart)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the "edit" template)' do
        body_part = BodyPart.create! valid_attributes
        put :update, params: { id: body_part.to_param, body_part: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested body_part' do
      body_part = BodyPart.create! valid_attributes
      expect {
        delete :destroy, params: { id: body_part.to_param }
      }.to change(BodyPart, :count).by(-1)
    end

    it 'redirects to the body_parts list' do
      body_part = BodyPart.create! valid_attributes
      delete :destroy, params: { id: body_part.to_param }
      expect(response).to redirect_to(body_parts_url)
    end
  end
end
