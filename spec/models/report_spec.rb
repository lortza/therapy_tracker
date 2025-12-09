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
  describe "#exercise_log_count_by_body_part" do
    let(:body_part1) { create(:body_part, user: user, name: "Knee") }
    let(:body_part2) { create(:body_part, user: user, name: "Back") }
    let(:exercise) { create(:exercise, user: user) }
    let!(:exercise_log1) { create(:exercise_log, user: user, exercise: exercise, body_part: body_part1) }
    let!(:exercise_log2) { create(:exercise_log, user: user, exercise: exercise, body_part: body_part1) }
    let!(:exercise_log3) { create(:exercise_log, user: user, exercise: exercise, body_part: body_part2) }

    let(:report) { Report.new(user: user, timeframe: nil, body_part_id: nil) }

    it "returns an array of arrays with body part names and counts" do
      result = report.exercise_log_count_by_body_part

      expect(result).to be_an(Array)
      expect(result.first).to be_an(Array)
      expect(result.first.size).to eq(2)
    end

    it "returns correct counts for each body part" do
      result = report.exercise_log_count_by_body_part

      expect(result).to include(["Knee", 2])
      expect(result).to include(["Back", 1])
    end

    it "orders results alphabetically by body part name" do
      result = report.exercise_log_count_by_body_part

      expect(result).to eq([["Back", 1], ["Knee", 2]])
    end

    it "only includes exercise logs for the current user" do
      other_user = create(:user)
      other_body_part = create(:body_part, user: other_user, name: "Other Body Part")
      other_exercise = create(:exercise, user: other_user)
      create(:exercise_log, user: other_user, exercise: other_exercise, body_part: other_body_part)

      result = report.exercise_log_count_by_body_part

      expect(result.map(&:first)).not_to include("Other Body Part")
    end

    it "only includes logs for the given timeframe" do
      exercise2 = create(:exercise, user: user)
      create(:exercise_log, user: user, exercise: exercise2, body_part: body_part1, occurred_at: 10.days.ago)
      create(:exercise_log, user: user, exercise: exercise2, body_part: body_part1, occurred_at: 2.days.ago)

      filtered_report = Report.new(user: user, timeframe: 7, body_part_id: nil)
      result = filtered_report.exercise_log_count_by_body_part

      # Only the log from 2 days ago should be included (10 days ago is outside the 7-day window)
      # The let block logs don't have occurred_at set, so they're excluded from the timeframe query
      expect(result.find { |name, _count| name == "Knee" }[1]).to eq(1)
    end

    it "only includes logs for the given body part" do
      body_part3 = create(:body_part, user: user, name: "Shoulder")
      create(:exercise_log, user: user, exercise: exercise, body_part: body_part3)

      filtered_report = Report.new(user: user, timeframe: nil, body_part_id: body_part1.id)
      result = filtered_report.exercise_log_count_by_body_part

      expect(result.map(&:first)).not_to include("Shoulder")
      expect(result.map(&:first)).not_to include("Back")
      expect(result).to eq([["Knee", 2]])
    end
  end
end
