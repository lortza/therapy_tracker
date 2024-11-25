# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Exercises", type: :request do
  let!(:user) { create(:user) }
  let!(:exercise) { create(:exercise, user_id: user.id) }

  describe "Public access to exercises" do
    it "denies access to exercises#new" do
      get new_exercise_path
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to exercises#show" do
      get exercise_path(exercise.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to exercises#edit" do
      get edit_exercise_path(exercise.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to exercises#create" do
      exercise_attributes = build(:exercise, user_id: user.id).attributes

      expect {
        post exercises_path(exercise_attributes)
      }.to_not change(Exercise, :count)

      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to exercises#update" do
      patch exercise_path(exercise, exercise: exercise.attributes)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to exercises#destroy" do
      delete exercise_path(exercise)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "Authenticated access to exercises" do
    it "renders exercises#new" do
      sign_in(user)
      get new_exercise_path

      expect(response).to be_successful
      expect(response).to render_template(:new)
    end

    it "renders exercises#show" do
      sign_in(user)
      get exercise_path(exercise.id)

      expect(response).to be_successful
      expect(response.body).to include(exercise.name)
    end

    it "renders exercises#edit" do
      sign_in(user)
      get edit_exercise_path(exercise.id)

      expect(response).to be_successful
      expect(response).to render_template(:edit)
      expect(response.body).to include(exercise.name)
    end

    it "renders exercises#create" do
      sign_in(user)
      exercise_attributes = build(:exercise, user_id: user.id).attributes

      expect {
        post exercises_path(exercise: exercise_attributes)
      }.to change(Exercise, :count)

      expect(response).to redirect_to exercises_url
    end

    it "renders exercises#update" do
      sign_in(user)
      new_name = "completely different name"
      patch exercise_path(exercise, exercise: {name: new_name})

      expect(response).to redirect_to exercises_url
    end

    it "renders exercises#destroy" do
      sign_in(user)
      delete exercise_path(exercise)

      expect(response).to redirect_to exercises_url
      expect(response.body).to_not include(exercise.name)
    end
  end
end
