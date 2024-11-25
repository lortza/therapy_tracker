# frozen_string_literal: true

require "rails_helper"

RSpec.describe PtSessionLogs::ExerciseLogsController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(get: "/pt_session_logs/1/exercise_logs/new").to route_to("pt_session_logs/exercise_logs#new", pt_session_log_id: "1")
    end

    it "routes to #show" do
      expect(get: "/pt_session_logs/1/exercise_logs/1").to route_to("pt_session_logs/exercise_logs#show", pt_session_log_id: "1", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/pt_session_logs/1/exercise_logs/1/edit").to route_to("pt_session_logs/exercise_logs#edit", pt_session_log_id: "1", id: "1")
    end

    it "routes to #create" do
      expect(post: "/pt_session_logs/1/exercise_logs").to route_to("pt_session_logs/exercise_logs#create", pt_session_log_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "/pt_session_logs/1/exercise_logs/1").to route_to("pt_session_logs/exercise_logs#update", pt_session_log_id: "1", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/pt_session_logs/1/exercise_logs/1").to route_to("pt_session_logs/exercise_logs#update", pt_session_log_id: "1", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/pt_session_logs/1/exercise_logs/1").to route_to("pt_session_logs/exercise_logs#destroy", pt_session_log_id: "1", id: "1")
    end
  end
end
