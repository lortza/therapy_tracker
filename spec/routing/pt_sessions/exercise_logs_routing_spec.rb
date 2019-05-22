# frozen_string_literal: true

require "rails_helper"

RSpec.describe PtSessions::ExerciseLogsController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(:get => "/pt_sessions/1/exercise_logs/new").to route_to("pt_sessions/exercise_logs#new", :pt_session_id => "1")
    end

    it "routes to #show" do
      expect(:get => "/pt_sessions/1/exercise_logs/1").to route_to("pt_sessions/exercise_logs#show", :pt_session_id => "1", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/pt_sessions/1/exercise_logs/1/edit").to route_to("pt_sessions/exercise_logs#edit", :pt_session_id => "1", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/pt_sessions/1/exercise_logs").to route_to("pt_sessions/exercise_logs#create", :pt_session_id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/pt_sessions/1/exercise_logs/1").to route_to("pt_sessions/exercise_logs#update", :pt_session_id => "1", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/pt_sessions/1/exercise_logs/1").to route_to("pt_sessions/exercise_logs#update", :pt_session_id => "1", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/pt_sessions/1/exercise_logs/1").to route_to("pt_sessions/exercise_logs#destroy", :pt_session_id => "1", :id => "1")
    end
  end
end