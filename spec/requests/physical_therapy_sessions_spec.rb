require 'rails_helper'

RSpec.describe "PhysicalTherapySessions", type: :request do
  describe "GET /physical_therapy_sessions" do
    it "works! (now write some real specs)" do
      get physical_therapy_sessions_path
      expect(response).to have_http_status(200)
    end
  end
end
