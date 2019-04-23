# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PtSession, type: :model do
  context "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:body_part) }
    it { should have_many(:pt_homework_exercises) }
    it { should have_many(:homework_exercises).through(:pt_homework_exercises) }
    it { should have_many(:pt_session_exercises) }
    it { should have_many(:session_exercises).through(:pt_session_exercises) }
  end

  context "validations" do
    it { should validate_presence_of(:body_part_id) }
    it { should validate_presence_of(:datetime_occurred) }
    it { should validate_presence_of(:exercise_notes) }
    it { should validate_presence_of(:homework) }
    it { should validate_presence_of(:duration) }

    it { should validate_numericality_of(:duration) }
  end
end
