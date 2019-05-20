# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PtSession, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:body_part) }
    it { should have_many(:exercise_logs) }
    it { should have_many(:pt_homework_exercises) }
    it { should have_many(:homework_exercises).through(:pt_homework_exercises) }
  end

  context 'validations' do
    it { should validate_presence_of(:body_part_id) }
    it { should validate_presence_of(:datetime_occurred) }
    it { should validate_presence_of(:exercise_notes) }
    it { should validate_presence_of(:homework) }
    it { should validate_presence_of(:duration) }

    it { should validate_numericality_of(:duration) }
  end

  context 'delegations' do
    it { should delegate_method(:name).to(:body_part).with_prefix }
  end

  describe 'self.past_week' do
    it 'returns only the logs that occurred between today and the past 7 days' do
      pt_session = create(:pt_session, datetime_occurred: Date.today.to_datetime - 2.days)

      expect(PtSession.past_week).to include(pt_session)
    end

    it 'does not return logs that occurred outside of 7 days' do
      pt_session1 = create(:pt_session, datetime_occurred: Date.today.to_datetime - 8.days)
      pt_session2 = create(:pt_session, datetime_occurred: Date.today.to_datetime + 2.days)

      expect(PtSession.past_week).to_not include(pt_session1)
      expect(PtSession.past_week).to_not include(pt_session2)
    end
  end

  describe 'self.past_two_weeks' do
    it 'returns logs that occurred within the past 14 days' do
      pt_session = create(:pt_session, datetime_occurred: Date.today.to_datetime - 12.days)

      expect(PtSession.past_two_weeks).to include(pt_session)
    end

    it 'does not return logs that occurred outside of 14 days' do
      pt_session1 = create(:pt_session, datetime_occurred: Date.today.to_datetime - 20.days)
      pt_session2 = create(:pt_session, datetime_occurred: Date.today.to_datetime + 2.days)

      expect(PtSession.past_two_weeks).to_not include(pt_session1)
      expect(PtSession.past_two_weeks).to_not include(pt_session2)
    end
  end

  describe 'self.exercise_counts' do
    xit 'returns a count of all exercises grouped by date' do
    end
  end
end
