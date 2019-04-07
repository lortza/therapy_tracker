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
    it { should validate_presence_of(:burn_rep).on(:update) }

    it { should validate_numericality_of(:sets) }
    it { should validate_numericality_of(:reps) }
    it { should validate_numericality_of(:rep_length) }
    it { should validate_numericality_of(:burn_rep).on(:update) }
  end

  context 'delegations' do
    it { should delegate_method(:name).to(:body_part).with_prefix }
    it { should delegate_method(:name).to(:exercise).with_prefix }
  end
end
