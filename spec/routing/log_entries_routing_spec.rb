require "rails_helper"

RSpec.describe LogEntriesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/log_entries").to route_to("log_entries#index")
    end

    it "routes to #new" do
      expect(:get => "/log_entries/new").to route_to("log_entries#new")
    end

    it "routes to #show" do
      expect(:get => "/log_entries/1").to route_to("log_entries#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/log_entries/1/edit").to route_to("log_entries#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/log_entries").to route_to("log_entries#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/log_entries/1").to route_to("log_entries#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/log_entries/1").to route_to("log_entries#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/log_entries/1").to route_to("log_entries#destroy", :id => "1")
    end
  end
end
