require 'rails_helper'

RSpec.describe "LogEntries", type: :request do
  describe "GET /log_entries" do
    it "works! (now write some real specs)" do
      get log_entries_path
      expect(response).to have_http_status(200)
    end
  end
end
