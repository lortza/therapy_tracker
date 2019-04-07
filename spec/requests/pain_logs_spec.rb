# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "PainLogs", type: :request do
  describe "GET /pain_logs" do
    it "works! (now write some real specs)" do
      get pain_logs_path
      expect(response).to have_http_status(200)
    end
  end
end
