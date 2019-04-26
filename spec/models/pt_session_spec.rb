# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PtSession, type: :model do
  context "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:body_part) }
    it { should have_many(:pt_homework_exercises) }
    it { should have_many(:homework_exercises).through(:pt_homework_exercises) }
    it { should have_many(:pt_session_exercises) }
  end

  context "validations" do
    it { should validate_presence_of(:body_part_id) }
    it { should validate_presence_of(:datetime_occurred) }
    it { should validate_presence_of(:exercise_notes) }
    it { should validate_presence_of(:homework) }
    it { should validate_presence_of(:duration) }

    it { should validate_numericality_of(:duration) }
  end

  describe '#blank_stats?' do
    it 'returns true if sets are blank' do
      pt_session_exercise = build(:pt_session_exercise, sets: nil)
      expect(pt_session_exercise.blank_stats?).to be true
    end

    it 'returns true if reps are blank' do
      pt_session_exercise = build(:pt_session_exercise, reps: nil)
      expect(pt_session_exercise.blank_stats?).to be true
    end

    it 'returns false if there are both sets and reps' do
      pt_session_exercise = build(:pt_session_exercise, sets: 1, reps: 1)
      expect(pt_session_exercise.blank_stats?).to be false
    end
  end
end
