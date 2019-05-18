# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExerciseLogsController, type: :controller do
  login_user

  let(:valid_attributes) { build(:exercise_log, user_id: subject.current_user.id).attributes }
  let(:invalid_attributes) { build(:exercise_log, user_id: subject.current_user.id, sets: nil).attributes }

  describe 'GET #index' do
    it 'returns a success response' do
      ExerciseLog.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      exercise_log = ExerciseLog.create! valid_attributes
      get :show, params: {id: exercise_log.to_param}
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
      exercise_log = ExerciseLog.create! valid_attributes
      get :edit, params: {id: exercise_log.to_param}
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new ExerciseLog' do
        expect {
          post :create, params: {exercise_log: valid_attributes}
        }.to change(ExerciseLog, :count).by(1)
      end

      context 'when created independently of a pt session' do
        it 'redirects to the logs index page' do
          post :create, params: {exercise_log: valid_attributes}
          expect(response).to redirect_to(ExerciseLog.last)
        end
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the "new" template)' do
        post :create, params: {exercise_log: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { build(:exercise_log, user_id: subject.current_user.id, sets: 3).attributes }

      it 'updates the requested exercise_log' do
        exercise_log = ExerciseLog.create! valid_attributes
        put :update, params: {id: exercise_log.to_param, exercise_log: new_attributes}
        exercise_log.reload
      end

      it 'redirects to the exercise_log' do
        exercise_log = ExerciseLog.create! valid_attributes
        put :update, params: {id: exercise_log.to_param, exercise_log: valid_attributes}
        expect(response).to redirect_to(exercise_log)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the "edit" template)' do
        exercise_log = ExerciseLog.create! valid_attributes
        put :update, params: {id: exercise_log.to_param, exercise_log: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested exercise_log' do
      exercise_log = ExerciseLog.create! valid_attributes
      expect {
        delete :destroy, params: {id: exercise_log.to_param}
      }.to change(ExerciseLog, :count).by(-1)
    end

    it 'redirects to the exercise_logs list' do
      exercise_log = ExerciseLog.create! valid_attributes
      delete :destroy, params: {id: exercise_log.to_param}
      expect(response).to redirect_to(root_url)
    end
  end

end
