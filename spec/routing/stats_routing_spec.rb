# frozen_string_literal: true

require "rails_helper"

RSpec.describe StatsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/stats").to route_to("stats#index")
    end
  end
end
