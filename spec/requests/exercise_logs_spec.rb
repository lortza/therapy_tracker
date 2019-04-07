# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "ExerciseLogs", type: :request do
  describe "GET /exercise_logs" do
    it "works! (now write some real specs)" do
      get exercise_logs_path
      expect(response).to have_http_status(200)
    end
  end
end
