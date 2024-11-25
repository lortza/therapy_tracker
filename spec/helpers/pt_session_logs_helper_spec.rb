# frozen_string_literal: true

require "rails_helper"

RSpec.describe PtSessionLogsHelper, type: :helper do
  it "should display exercise stats" do
    log = build(:exercise_log, resistance: "yellow band")

    expect(helper.display_exercise_stats(log)).to eq("2 sets of 10 reps with yellow band")
  end
end
