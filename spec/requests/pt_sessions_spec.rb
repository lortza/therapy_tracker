# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "PtSessions", type: :request do
  describe "GET /pt_sessions" do
    it "works! (now write some real specs)" do
      get pt_sessions_path
      expect(response).to have_http_status(200)
    end
  end
end
