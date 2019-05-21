# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExerciseLogsHelper, type: :helper do
  it 'should format exercise stats' do
    log = build(:exercise_log, per_side: true, sets: 3, reps: 15, rep_length: 10)

    expect(helper.format_exercise_stats(log)).to eq('3 sets / 15 reps at 10 seconds each per leg')
  end

  it 'should format resistance' do
    log = build(:exercise_log, resistance: 'green band')

    expect(helper.format_resistance(log)).to eq(' | Resistance: green band. ')
  end
end
