# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExerciseLog, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
  end

  context 'validations' do
    it { should validate_presence_of(:body_part_id) }
    it { should validate_presence_of(:datetime_occurred) }
    it { should validate_presence_of(:exercise_id) }
    it { should validate_presence_of(:sets) }
    it { should validate_presence_of(:reps) }
    it { should validate_presence_of(:rep_length) }
    it { should validate_presence_of(:burn_set).on(:update) }
    it { should validate_presence_of(:burn_rep).on(:update) }

    it { should validate_numericality_of(:sets) }
    it { should validate_numericality_of(:reps) }
    it { should validate_numericality_of(:rep_length) }
    it { should validate_numericality_of(:burn_set).on(:update) }
    it { should validate_numericality_of(:burn_rep).on(:update) }
  end

  context 'delegations' do
    it { should delegate_method(:name).to(:body_part).with_prefix }
    it { should delegate_method(:name).to(:exercise).with_prefix }
  end

  describe 'self.minutes_spent_by_day' do
    it 'returns a hash of dates and total minutes' do
      exercise_log1 = create(:exercise_log,
                             datetime_occurred: '2019-12-30',
                             sets: 1, reps: 1, rep_length: 120)

      exercise_log2 = create(:exercise_log,
                             datetime_occurred: '2019-12-30',
                             sets: 1, reps: 1, rep_length: 120)

      exercise_log3 = create(:exercise_log,
                             datetime_occurred: '2019-12-31',
                             sets: 1, reps: 1, rep_length: 60)

      expected_output = {
        'Mon, 30 Dec 2019'.to_date => 4,
        'Tue, 31 Dec 2019'.to_date => 1
      }

      expect(ExerciseLog.minutes_spent_by_day).to eq(expected_output)
    end
  end

  describe '#seconds_spent' do
    it 'returns the total number of seconds_spent exercised per log' do
      exercise_log = build(:exercise_log, sets: 2, reps: 10, rep_length: 5)
      expect(exercise_log.seconds_spent).to eq(100)
    end

    it 'doubles the value if per_side is true' do
      exercise_log = build(:exercise_log, sets: 2, reps: 10, rep_length: 5, per_side: true)
      expect(exercise_log.seconds_spent).to eq(200)
    end

    it 'handles 0s gracefully' do
      exercise_log = build(:exercise_log, sets: 0, reps: 0, rep_length: 5)
      expect(exercise_log.seconds_spent).to eq(0)
    end
  end

  describe '#minutes_spent' do
    it 'returns the total number of minutes_spent exercised per log' do
      exercise_log = build(:exercise_log)
      allow(exercise_log).to receive(:seconds_spent).and_return(120)

      expect(exercise_log.minutes_spent).to eq(2)
    end

    it 'gracefully handles amounts less than 1 minute' do
      exercise_log = build(:exercise_log)
      allow(exercise_log).to receive(:seconds_spent).and_return(30)

      expect(exercise_log.minutes_spent).to eq(0.5)
    end
  end
end
