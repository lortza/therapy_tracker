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

  describe 'self.past_two_weeks' do
    xit 'returns only the logs between today and the past 14 days' do
    end
  end

  xdescribe '#avg_pain_level_by_day' do
    it 'returns the average pain level of minutes exercised per log' do
      pain_log = build(:pain_log)
      allow(pain_log).to receive(:seconds_spent).and_return(120)

      expect(PainLog.avg_pain_level_by_day).to eq(2)
    end
  end
end
