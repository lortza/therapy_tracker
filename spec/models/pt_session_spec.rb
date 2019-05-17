# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PtSession, type: :model do
  context "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:body_part) }
    it { should have_many(:exercise_logs) }
    it { should have_many(:pt_homework_exercises) }
    it { should have_many(:homework_exercises).through(:pt_homework_exercises) }
  end

  context "validations" do
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
    before(:each) do
      @user = create(:user)
    end
    it 'returns only the logs between today and the past 7 days' do
      pt_session = create(:pt_session, datetime_occurred: Date.today.to_datetime - 2.days, user_id: @user.id)

      expect(PtSession.past_week.first).to eq pt_session
    end

    it 'returns empty if the datetime_occurreds are out of the range 7 days past' do
      pt_session = create(:pt_session, datetime_occurred: Date.today.to_datetime - 8.days, user_id: @user.id)
      pt_session = create(:pt_session, datetime_occurred: Date.today.to_datetime + 2.days, user_id: @user.id)

      expect(PtSession.past_week).to be_empty
    end
  end

  describe 'self.past_two_weeks' do
    before(:each) do
      @user = create(:user)
    end
    it 'returns only the logs between today and the past 14 days' do
      pt_session = create(:pt_session, datetime_occurred: Date.today.to_datetime - 12.days, user_id: @user.id)

      expect(PtSession.past_two_weeks.first).to eq pt_session
    end

    it 'returns empty if the datetime_occurreds are out of the range 14 days past' do
      pt_session1 = create(:pt_session, datetime_occurred: Date.today.to_datetime - 20.days, user_id: @user.id)
      pt_session2 = create(:pt_session, datetime_occurred: Date.today.to_datetime + 2.days, user_id: @user.id)

      expect(PtSession.past_two_weeks).to be_empty
    end
  end

  describe 'self.exercise_counts' do
    xit 'returns a count of all exercises grouped by date' do
    end
  end
end
