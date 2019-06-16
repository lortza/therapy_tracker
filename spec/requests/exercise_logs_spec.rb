# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ExerciseLogs', type: :request do
  let!(:user) { create(:user) }
  let!(:exercise_log) {
    create(:exercise_log,
           user_id: user.id,
           exercise_id: create(:exercise).id,
           body_part_id: create(:body_part).id)
  }

  describe 'Public access to exercise_logs' do
    it 'denies access to exercise_logs#new' do
      get new_exercise_log_path
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to exercise_logs#show' do
      get exercise_log_path(exercise_log.id)
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to exercise_logs#edit' do
      get edit_exercise_log_path(exercise_log.id)
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to exercise_logs#create' do
      exercise_log_attributes = build(:exercise_log, user_id: user.id).attributes

      expect {
        post exercise_logs_path(exercise_log_attributes)
      }.to_not change(ExerciseLog, :count)

      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to exercise_logs#update' do
      patch exercise_log_path(exercise_log, exercise_log: exercise_log.attributes)
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to exercise_logs#destroy' do
      delete exercise_log_path(exercise_log)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'Authenticated access to exercise_logs' do
    it 'renders exercise_logs#new' do
      sign_in(user)
      get new_exercise_log_path

      expect(response).to be_successful
      expect(response).to render_template(:new)
    end

    it 'renders exercise_logs#show' do
      sign_in(user)
      get exercise_log_path(exercise_log.id)

      expect(response).to be_successful
      expect(response.body).to include(exercise_log.resistance)
    end

    it 'renders exercise_logs#edit' do
      sign_in(user)
      get edit_exercise_log_path(exercise_log.id)

      expect(response).to be_successful
      expect(response).to render_template(:edit)
      expect(response.body).to include(exercise_log.resistance)
    end

    it 'renders exercise_logs#create' do
      sign_in(user)
      exercise_log_attributes = build(:exercise_log,
                                      user_id: user.id,
                                      exercise_id: create(:exercise).id,
                                      body_part_id: create(:body_part).id).attributes

      expect {
        post exercise_logs_path(exercise_log: exercise_log_attributes)
      }.to change(ExerciseLog, :count)

      expect(response).to redirect_to exercise_log_url(exercise_log.id + 1)
    end

    it 'renders exercise_logs#update' do
      sign_in(user)
      new_resistance = 'completely different resistance level'
      patch exercise_log_path(exercise_log, exercise_log: { body_part_id: new_resistance })

      expect(response).to be_successful
    end

    it 'renders exercise_logs#destroy' do
      sign_in(user)

      expect {
        delete exercise_log_path(exercise_log)
      }.to change(ExerciseLog, :count)

      expect(response).to redirect_to root_url
    end
  end
end
