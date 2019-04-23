# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Exercise, type: :model do
  context "associations" do
    it { should belong_to(:user) }
    it { should have_many(:exercise_logs) }
    it { should have_many(:logs) }
    it { should have_many(:pt_homework_exercises) }  # the join table
    it { should have_many(:pt_homework_sessions).through(:pt_homework_exercises) }
    it { should have_many(:pt_session_exercises) } # the join table
    it { should have_many(:pt_exercise_sessions).through(:pt_session_exercises) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:default_sets) }
    it { should validate_presence_of(:default_reps) }
    it { should validate_presence_of(:default_rep_length) }
  end

  describe 'self.has_logs' do
    it 'returns all exercises that have logs' do
      exercise = create(:exercise, :with_3_exercise_logs )
      expect(Exercise.has_logs).to include(exercise)
    end

    it 'does not include exercises that do not have logs' do
      exercise = create(:exercise)
      expect(Exercise.has_logs).not_to include(exercise)
    end
  end

  describe 'self.log_count_by_name' do
    let!(:exercise1) { create(:exercise, :with_3_exercise_logs, name: 'ex1') }
    let!(:exercise2) { create(:exercise, :with_3_exercise_logs, name: 'ex2') }

    it 'returns the exercise name and the count of its logs as a nested array' do
      expected_output = [['ex1', 3], ['ex2', 3]]
      expect(Exercise.log_count_by_name).to eq(expected_output)
    end
  end
end
