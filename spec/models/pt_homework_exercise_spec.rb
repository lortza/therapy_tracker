# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PtHomeworkExercise, type: :model do
  context 'associations' do
    it { should belong_to(:pt_session_log) }
    it { should belong_to(:exercise) }
  end

  context 'validations' do
    it { should validate_presence_of(:pt_session_log) }
    it { should validate_presence_of(:exercise) }
  end

  context 'attributes' do
    it 'should have all of its attributes' do
      expected_attributes = %w[id
                               pt_session_log_id
                               exercise_id
                               created_at updated_at]
      actual_attributes = build(:pt_homework_exercise).attributes.keys

      expect(actual_attributes).to match_array(expected_attributes)
    end
  end
end
