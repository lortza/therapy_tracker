# frozen_string_literal: true

require "rails_helper"

RSpec.describe PtSessionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/pt_sessions").to route_to("pt_sessions#index")
    end

    it "routes to #new" do
      expect(:get => "/pt_sessions/new").to route_to("pt_sessions#new")
    end

    it "routes to #show" do
      expect(:get => "/pt_sessions/1").to route_to("pt_sessions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/pt_sessions/1/edit").to route_to("pt_sessions#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/pt_sessions").to route_to("pt_sessions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/pt_sessions/1").to route_to("pt_sessions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/pt_sessions/1").to route_to("pt_sessions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/pt_sessions/1").to route_to("pt_sessions#destroy", :id => "1")
    end
  end
end
