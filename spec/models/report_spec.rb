# frozen_string_literal: true

require "rails_helper"

RSpec.describe Report, type: :model do
  let(:user) { create(:user) }

  xcontext "attributes" do
    it "should have all of its attributes" do
      expected_attributes = %w[filter_params]
      actual_attributes = build(:report).attributes.keys

      expect(actual_attributes).to match_array(expected_attributes)
    end
  end

  describe "pain_stats_by_body_part" do
    let(:body_part) { create(:body_part, user: user) }
    let(:pain) { create(:pain, user: user) }
    let!(:pain_log1) { create(:pain_log, user: user, pain: pain, body_part: body_part) }
    let!(:pain_log2) { create(:pain_log, user: user, pain: pain, body_part: body_part) }

    let(:report) do
      Report.new(
        user: user,
        timeframe: "",
        body_part_id: body_part.id
      )
    end

    it "returns a list of pain logs grouped by body parts" do
      results = report.pain_stats_by_body_part.first
      result_body_part = results[0]
      result_logs = results[1]

      expect(result_body_part).to eq(body_part)
      expect(result_logs).to include(pain_log1)
      expect(result_logs).to include(pain_log2)
    end
  end
end
