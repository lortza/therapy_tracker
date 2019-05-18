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
    xit 'returns pt_sessions logged in the past week' do
    end
  end

  describe 'self.past_two_weeks' do
    xit 'returns pt_sessions logged in the past 2 weeks' do
    end
  end

  describe 'self.exercise_counts' do
    xit 'returns a count of all exercises grouped by date' do
    end
  end
end
