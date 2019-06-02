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

  context 'attributes' do
    it 'should have all of its attributes' do
      expected_attributes = %w[id
                               body_part_id
                               datetime_occurred
                               pain_description
                               pain_id
                               pain_level
                               trigger
                               user_id
                               created_at updated_at]
      actual_attributes = build(:pain_log).attributes.keys

      expect(actual_attributes).to match_array(expected_attributes)
    end
  end

  describe 'self.for_past_n_days' do
    it 'returns logs that occurred between today and the past n days' do
      pain_log = create(:pain_log, datetime_occurred: 2.days.ago)
      expect(PainLog.for_past_n_days(7)).to include(pain_log)
    end

    it 'does not return logs that occurred outside of the past n days' do
      pain_log1 = create(:pain_log, datetime_occurred: 9.days.ago)
      pain_log2 = create(:pain_log, datetime_occurred: 2.days.from_now)

      expect(PainLog.for_past_n_days(7)).to_not include(pain_log1)
      expect(PainLog.for_past_n_days(7)).to_not include(pain_log2)
    end

    it 'returns an empty array if no logs occurred within the past n days' do
      create(:pain_log, datetime_occurred: 9.days.ago)
      expect(PainLog.for_past_n_days(7)).to eq([])
    end
  end

  describe 'self.for_body_part' do
    it 'returns logs for the given body part' do
      user = create(:user)
      arm = create(:body_part, name: 'arm', user_id: user.id)
      leg = create(:body_part, name: 'leg', user_id: user.id)
      arm_log1 = create(:pain_log, body_part_id: arm.id, user_id: user.id)
      arm_log2 = create(:pain_log, body_part_id: arm.id, user_id: user.id)
      leg_log = create(:pain_log, body_part_id: leg.id, user_id: user.id)

      expect(PainLog.for_body_part(arm.id)).to include(arm_log1, arm_log2)
      expect(PainLog.for_body_part(arm.id)).to_not include(leg_log)
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
