require "rails_helper"

RSpec.describe PhysicalTherapySessionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/physical_therapy_sessions").to route_to("physical_therapy_sessions#index")
    end

    it "routes to #new" do
      expect(:get => "/physical_therapy_sessions/new").to route_to("physical_therapy_sessions#new")
    end

    it "routes to #show" do
      expect(:get => "/physical_therapy_sessions/1").to route_to("physical_therapy_sessions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/physical_therapy_sessions/1/edit").to route_to("physical_therapy_sessions#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/physical_therapy_sessions").to route_to("physical_therapy_sessions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/physical_therapy_sessions/1").to route_to("physical_therapy_sessions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/physical_therapy_sessions/1").to route_to("physical_therapy_sessions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/physical_therapy_sessions/1").to route_to("physical_therapy_sessions#destroy", :id => "1")
    end
  end
end
