# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PainLog, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:pain) }
    it { should belong_to(:body_part) }
  end

  context 'validations' do
    it { should validate_presence_of(:datetime_occurred) }
    it { should validate_presence_of(:body_part_id) }
    it { should validate_presence_of(:pain_id) }
    it { should validate_presence_of(:pain_level) }
    it { should validate_presence_of(:pain_description) }
    it { should validate_presence_of(:trigger) }

    it { should validate_numericality_of(:pain_level) }
  end

  context 'delegations' do
    it { should delegate_method(:name).to(:body_part).with_prefix }
    it { should delegate_method(:name).to(:pain).with_prefix }
  end

  describe 'self.past_week' do
    it 'returns logs that occurred between today and the past 7 days' do
      pain_log = create(:pain_log, datetime_occurred: Date.today.to_datetime - 2.days)

      expect(PainLog.past_week).to include(pain_log)
    end

    it 'does not return pain_logs whose datetime_occurred out of the past 7 days' do
      pain_log1 = create(:pain_log, datetime_occurred: Date.today.to_datetime - 8.days)
      pain_log2 = create(:pain_log, datetime_occurred: Date.today.to_datetime + 2.days)

      expect(PainLog.past_week).to_not include(pain_log1)
      expect(PainLog.past_week).to_not include(pain_log2)
    end

    it 'returns an empty array if no logs occurred within the past 7 days' do
      pain_log = create(:pain_log, datetime_occurred: Date.today.to_datetime - 8.days)
      expect(PainLog.past_week).to eq([])
    end
  end

  describe 'self.past_two_weeks' do
    it 'returns logs that occurred between today and the past 14 days' do
      pain_log = create(:pain_log, datetime_occurred: Date.today.to_datetime - 12.days)

      expect(PainLog.past_two_weeks).to include(pain_log)
    end

    it 'does not return pain_logs whose datetime_occurred out of the past 14 days' do
      pain_log1 = create(:pain_log, datetime_occurred: Date.today.to_datetime - 20.days)
      pain_log2 = create(:pain_log, datetime_occurred: Date.today.to_datetime + 2.days)

      expect(PainLog.past_two_weeks).to_not include(pain_log1)
      expect(PainLog.past_two_weeks).to_not include(pain_log2)
    end

    it 'returns an empty array if no logs occurred within the past 14 days' do
      pain_log = create(:pain_log, datetime_occurred: Date.today.to_datetime - 16.days)
      expect(PainLog.past_two_weeks).to eq([])
    end
  end

  describe 'self.group_by_pain_and_count' do
    let!(:pain1) { create(:pain, :with_3_pain_logs, name: 'pain1') }
    let!(:pain2) { create(:pain, :with_3_pain_logs, name: 'pain2') }

    it 'returns the pain name and the count of its logs as a nested array' do
      expected_output = [['pain2', 3], ['pain1', 3]]
      expect(PainLog.group_by_pain_and_count).to match_array(expected_output)
    end
  end

  # describe '#avg_pain_level_by_day' do
  #   it 'returns the average pain level of minutes exercised per log' do
  #     pain_log = build(:pain_log)
  #     allow(pain_log).to receive(:seconds_spent).and_return(120)

  #     expect(PainLog.avg_pain_level_by_day).to eq(2)
  #   end
  # end
end
