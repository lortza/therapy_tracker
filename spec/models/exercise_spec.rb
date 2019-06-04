# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Exercise, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:exercise_logs) }
    it { should have_many(:logs) }
    it { should have_many(:pt_homework_exercises) } # the join table
    it { should have_many(:pt_homework_sessions).through(:pt_homework_exercises) }
  end

  context 'validations' do
    it { should validate_uniqueness_of(:name).case_insensitive.scoped_to(:user_id) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:default_sets) }
    it { should validate_presence_of(:default_reps) }
    it { should validate_presence_of(:default_rep_length) }
  end

  context 'attributes' do
    it 'should have all of its attributes' do
      expected_attributes = %w[id
                               default_per_side
                               default_rep_length
                               default_reps
                               default_resistance
                               default_sets
                               description
                               name
                               user_id
                               created_at updated_at]
      actual_attributes = build(:exercise).attributes.keys

      expect(actual_attributes).to match_array(expected_attributes)
    end
  end

  describe 'self.logs?' do
    it 'returns all exercises that have logs' do
      exercise = create(:exercise, :with_3_exercise_logs)
      expect(Exercise.logs?).to include(exercise)
    end

    it 'does not include exercises that do not have logs' do
      exercise = create(:exercise)
      expect(Exercise.logs?).not_to include(exercise)
    end
  end

  describe 'self.log_count_by_name' do
    let!(:exercise1) { create(:exercise, :with_3_exercise_logs, name: 'ex1') }
    let!(:exercise2) { create(:exercise, :with_3_exercise_logs, name: 'ex2') }
    let!(:exercise3) { create(:exercise, name: 'ex3') }

    it 'returns the exercise name and the count of its logs as a nested array' do
      expected_output = [['ex1', 3], ['ex2', 3]]
      expect(Exercise.log_count_by_name).to eq(expected_output)
    end

    it 'does not include exercises with fewer than 1 log' do
      insufficient_exercise = ['ex3', 0]
      expect(Exercise.log_count_by_name).not_to include(insufficient_exercise)
    end
  end

  describe 'self.by_name' do
    it 'returns a list of exercises ordered by name, ascending' do
      exercise1 = create(:exercise, name: 'a')
      exercise2 = create(:exercise, name: 'b')
      exercise3 = create(:exercise, name: 'c')

      expect(Exercise.by_name).to match_array([exercise1, exercise2, exercise3])
    end
  end

  describe 'self.search()' do
    let!(:ex1) { create(:exercise, name: 'ex1') }
    let!(:ex2) { create(:exercise, name: 'ex2') }

    it 'returns all exercises if no argument is supplied' do
      terms = ''
      expect(Exercise.search(terms).count).to eq(2)
    end

    it 'returns all matches for partial string matches' do
      terms = 'ex'
      expect(Exercise.search(terms).count).to eq(2)
    end

    it 'excludes items that have characters that are not included' do
      terms = 'x1'
      expect(Exercise.search(terms).count).to eq(1)
      expect(Exercise.search(terms)).to include(ex1)
      expect(Exercise.search(terms)).to_not include(ex2)
    end

    it 'returns an empty array if there are no matches' do
      terms = 'ex3'
      expect(Exercise.search(terms)).to eq([])
    end
  end
end
