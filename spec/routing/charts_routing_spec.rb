# frozen_string_literal: true

require "rails_helper"

RSpec.describe ChartsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/charts").to route_to("charts#index")
    end
  end
end
