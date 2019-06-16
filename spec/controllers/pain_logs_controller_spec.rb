# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PainLogsController, type: :controller do
  login_user

  let(:valid_attributes) {
    build(:pain_log,
          user_id: subject.current_user.id,
          body_part_id: create(:body_part).id,
          pain_id: create(:pain).id).attributes
  }

  let(:invalid_attributes) {
    build(:pain_log,
          user_id: subject.current_user.id,
          body_part_id: create(:body_part).id,
          pain_id: create(:pain).id,
          pain_level: '').attributes
  }

  describe 'GET #index' do
    it 'returns a success response' do
      PainLog.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      pain_log = PainLog.create! valid_attributes
      get :show, params: { id: pain_log.to_param }
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
      pain_log = PainLog.create! valid_attributes
      get :edit, params: { id: pain_log.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new PainLog' do
        expect {
          post :create, params: { pain_log: valid_attributes }
        }.to change(PainLog, :count).by(1)
      end

      it 'redirects to the home page' do
        post :create, params: { pain_log: valid_attributes }
        expect(response).to redirect_to(root_url)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { pain_log: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        build(:pain_log,
              user_id: subject.current_user.id,
              body_part_id: create(:body_part).id,
              pain_id: create(:pain).id,
              pain_description: 'updated description').attributes
      }

      it 'updates the requested pain_log' do
        pain_log = PainLog.create! valid_attributes
        put :update, params: { id: pain_log.to_param, pain_log: new_attributes }
        pain_log.reload
        expect(pain_log.pain_description).to eq(new_attributes['pain_description'])
      end

      it 'redirects to the home page' do
        pain_log = PainLog.create! valid_attributes
        put :update, params: { id: pain_log.to_param, pain_log: valid_attributes }
        expect(response).to redirect_to(root_url)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        pain_log = PainLog.create! valid_attributes
        put :update, params: { id: pain_log.to_param, pain_log: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested pain_log' do
      pain_log = PainLog.create! valid_attributes
      expect {
        delete :destroy, params: { id: pain_log.to_param }
      }.to change(PainLog, :count).by(-1)
    end

    it 'redirects to the home page' do
      pain_log = PainLog.create! valid_attributes
      delete :destroy, params: { id: pain_log.to_param }
      expect(response).to redirect_to(root_url)
    end
  end
end
