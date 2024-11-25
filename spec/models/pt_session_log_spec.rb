# frozen_string_literal: true

require "rails_helper"

RSpec.describe PtSessionLog, type: :model do
  context "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:body_part) }
    it { should have_many(:exercise_logs) }
    it { should have_many(:pt_homework_exercises) }
    it { should have_many(:homework_exercises).through(:pt_homework_exercises) }
  end

  context "validations" do
    it { should validate_presence_of(:body_part_id) }
    it { should validate_presence_of(:occurred_at) }
    it { should validate_presence_of(:exercise_notes) }
    it { should validate_presence_of(:homework) }
    it { should validate_presence_of(:duration) }

    it { should validate_numericality_of(:duration) }
  end

  context "delegations" do
    it { should delegate_method(:name).to(:body_part).with_prefix }
  end

  context "attributes" do
    it "should have all of its attributes" do
      expected_attributes = %w[id
        body_part_id
        occurred_at
        duration
        exercise_notes
        homework
        questions
        user_id
        created_at updated_at]
      actual_attributes = build(:pt_session_log).attributes.keys

      expect(actual_attributes).to match_array(expected_attributes)
    end
  end

  describe "self.for_past_n_days" do
    it "returns logs that occurred between today and the past n days" do
      pt_session_log = create(:pt_session_log, occurred_at: 2.days.ago)
      expect(PtSessionLog.for_past_n_days(7)).to include(pt_session_log)
    end

    it "does not return logs that occurred outside of the past n days" do
      pt_session_log1 = create(:pt_session_log, occurred_at: 9.days.ago)
      pt_session_log2 = create(:pt_session_log, occurred_at: 2.days.from_now)

      expect(PtSessionLog.for_past_n_days(7)).to_not include(pt_session_log1)
      expect(PtSessionLog.for_past_n_days(7)).to_not include(pt_session_log2)
    end

    it "returns an empty array if no logs occurred within the past n days" do
      create(:pt_session_log, occurred_at: 9.days.ago)
      expect(PtSessionLog.for_past_n_days(7)).to eq([])
    end
  end

  describe "self.for_body_part" do
    it "returns logs for the given body part" do
      user = create(:user)
      arm = create(:body_part, name: "arm", user_id: user.id)
      leg = create(:body_part, name: "leg", user_id: user.id)
      arm_log1 = create(:pt_session_log, body_part_id: arm.id, user_id: user.id)
      arm_log2 = create(:pt_session_log, body_part_id: arm.id, user_id: user.id)
      leg_log = create(:pt_session_log, body_part_id: leg.id, user_id: user.id)

      expect(PtSessionLog.for_body_part(arm.id)).to include(arm_log1, arm_log2)
      expect(PtSessionLog.for_body_part(arm.id)).to_not include(leg_log)
    end
  end

  describe "self.exercise_counts" do
    xit "returns a count of all exercises grouped by date"
  end
end
