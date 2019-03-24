require "rails_helper"

RSpec.describe ExerciseLogsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/exercise_logs").to route_to("exercise_logs#index")
    end

    it "routes to #new" do
      expect(:get => "/exercise_logs/new").to route_to("exercise_logs#new")
    end

    it "routes to #show" do
      expect(:get => "/exercise_logs/1").to route_to("exercise_logs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/exercise_logs/1/edit").to route_to("exercise_logs#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/exercise_logs").to route_to("exercise_logs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/exercise_logs/1").to route_to("exercise_logs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/exercise_logs/1").to route_to("exercise_logs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/exercise_logs/1").to route_to("exercise_logs#destroy", :id => "1")
    end
  end
end
