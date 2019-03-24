require 'rails_helper'

RSpec.describe LogEntry, type: :model do
  context "associations" do
    it { should belong_to(:user) }
  end

  context "validations" do
    it { should validate_presence_of(:target_body_part) }
    it { should validate_presence_of(:sets) }
    it { should validate_presence_of(:reps) }
    it { should validate_presence_of(:exercise_name) }
    it { should validate_presence_of(:current_pain_level) }
    it { should validate_presence_of(:current_pain_frequency) }

    it { should validate_numericality_of(:sets) }
    it { should validate_numericality_of(:reps) }
    it { should validate_numericality_of(:current_pain_level) }
  end
end
