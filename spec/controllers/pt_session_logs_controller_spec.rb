# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PtSessionLogsController, type: :controller do
  login_user

  let(:valid_attributes) {
    build(:pt_session_log,
          user_id: subject.current_user.id,
          body_part_id: create(:body_part).id).attributes
  }

  let(:invalid_attributes) {
    build(:pt_session_log,
          user_id: subject.current_user.id,
          body_part_id: create(:body_part).id,
          homework: '').attributes
  }

  describe 'GET #index' do
    it 'returns a success response' do
      PtSessionLog.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      pt_session_log = PtSessionLog.create! valid_attributes
      get :show, params: { id: pt_session_log.to_param }
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
      pt_session_log = PtSessionLog.create! valid_attributes
      get :edit, params: { id: pt_session_log.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new PtSessionLog' do
        expect {
          post :create, params: { pt_session_log: valid_attributes }
        }.to change(PtSessionLog, :count).by(1)
      end

      it 'redirects to the home page' do
        post :create, params: { pt_session_log: valid_attributes }
        expect(response).to redirect_to(root_url)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the new pt session template)' do
        post :create, params: { pt_session_log: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        build(:pt_session_log,
              user_id: subject.current_user.id,
              body_part_id: create(:body_part).id,
              homework: 'updated homework').attributes
      }

      it 'updates the requested pt_session_log' do
        pt_session_log = PtSessionLog.create! valid_attributes
        put :update, params: { id: pt_session_log.to_param, pt_session_log: new_attributes }
        pt_session_log.reload
        expect(pt_session_log.homework).to eq(new_attributes['homework'])
      end

      it 'redirects to the home page' do
        pt_session_log = PtSessionLog.create! valid_attributes
        put :update, params: { id: pt_session_log.to_param, pt_session_log: valid_attributes }
        expect(response).to redirect_to(root_url)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the edit pt session template)' do
        pt_session_log = PtSessionLog.create! valid_attributes
        put :update, params: { id: pt_session_log.to_param, pt_session_log: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested pt_session_log' do
      pt_session_log = PtSessionLog.create! valid_attributes
      expect {
        delete :destroy, params: { id: pt_session_log.to_param }
      }.to change(PtSessionLog, :count).by(-1)
    end

    it 'redirects to the home page' do
      pt_session_log = PtSessionLog.create! valid_attributes
      delete :destroy, params: { id: pt_session_log.to_param }
      expect(response).to redirect_to(root_url)
    end
  end
end
