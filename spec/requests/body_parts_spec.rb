require 'rails_helper'

RSpec.describe "BodyParts", type: :request do
  describe "GET /body_parts" do
    it "works! (now write some real specs)" do
      get body_parts_path
      expect(response).to have_http_status(200)
    end
  end
end
