# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Pains", type: :request do
  describe "GET /pains" do
    it "works! (now write some real specs)" do
      get pains_path
      expect(response).to have_http_status(200)
    end
  end
end
