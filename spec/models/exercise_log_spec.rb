# frozen_string_literal: true

require "rails_helper"

RSpec.describe ExerciseLog, type: :model do
  context "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:exercise) }
    it { should belong_to(:body_part) }
    it { should belong_to(:pt_session_log).optional }
  end

  context "validations" do
    it { should validate_presence_of(:body_part_id) }
    it { should validate_presence_of(:occurred_at) }
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

  context "delegations" do
    it { should delegate_method(:name).to(:body_part).with_prefix }
    it { should delegate_method(:name).to(:exercise).with_prefix }
  end

  context "attributes" do
    it "should have all of its attributes" do
      expected_attributes = %w[id
        body_part_id
        burn_rep
        burn_set
        occurred_at
        exercise_id
        per_side
        progress_note
        pt_session_log_id
        rep_length
        reps
        resistance
        sets
        user_id
        created_at updated_at]
      actual_attributes = build(:exercise_log).attributes.keys

      expect(actual_attributes).to match_array(expected_attributes)
    end
  end

  describe "scopes" do
    describe "at_home" do
      it "returns exercise_logs that are not associated with a pt_session_log" do
        exercise_log = create(:exercise_log, pt_session_log_id: nil)

        expect(ExerciseLog.at_home).to include(exercise_log)
      end

      it "does not return exercise_logs that are associated with a pt_session_log" do
        pt_session_log = create(:pt_session_log)
        exercise_log = create(:exercise_log, pt_session_log_id: pt_session_log.id)

        expect(ExerciseLog.at_home).to_not include(exercise_log)
      end

      it "returns an empty array if all exercise_logs belong to pt_session_logs" do
        pt_session_log = create(:pt_session_log)
        build(:exercise_log, pt_session_log_id: pt_session_log.id)

        expect(ExerciseLog.at_home).to eq([])
      end
    end

    describe "at_pt" do
      it "returns exercise_logs that are associated with pt_session_logs" do
        pt_session_log = create(:pt_session_log)
        exercise_log = create(:exercise_log, pt_session_log_id: pt_session_log.id)

        expect(ExerciseLog.at_pt).to include(exercise_log)
      end

      it "does not return exercise_logs that are not associated with a pt_session_log" do
        exercise_log = create(:exercise_log, pt_session_log_id: nil)
        expect(ExerciseLog.at_pt).to_not include(exercise_log)
      end

      it "returns an empty array if no exercise_logs belong to a pt_session_log" do
        build(:exercise_log, pt_session_log_id: nil)
        expect(ExerciseLog.at_pt).to eq([])
      end
    end
  end

  describe "chronologically" do
    it "is ordered by occurred_at in ascending order" do
      user = create(:user)
      first_log = create(:exercise_log,
        user_id: user.id,
        occurred_at: "2019-01-01 1:00:00")

      last_log = create(:exercise_log,
        user_id: user.id,
        occurred_at: "2019-01-01 2:00:00")

      expect(ExerciseLog.chronologically.first).to eq(first_log)
      expect(ExerciseLog.chronologically.last).to eq(last_log)
    end
  end

  describe "self.for_past_n_days" do
    it "returns logs that occurred between today and the past n days" do
      exercise_log = create(:exercise_log, occurred_at: 2.days.ago)
      expect(ExerciseLog.for_past_n_days(7)).to include(exercise_log)
    end

    it "does not return logs that occurred outside of the past n days" do
      exercise_log1 = create(:exercise_log, occurred_at: 9.days.ago)
      exercise_log2 = create(:exercise_log, occurred_at: 2.days.from_now)

      expect(ExerciseLog.for_past_n_days(7)).to_not include(exercise_log1)
      expect(ExerciseLog.for_past_n_days(7)).to_not include(exercise_log2)
    end

    it "returns an empty array if no logs occurred within the past n days" do
      create(:exercise_log, occurred_at: 9.days.ago)
      expect(ExerciseLog.for_past_n_days(7)).to eq([])
    end
  end

  describe "self.for_body_part" do
    it "returns logs for the given body part" do
      user = create(:user)
      arm = create(:body_part, name: "arm", user_id: user.id)
      leg = create(:body_part, name: "leg", user_id: user.id)
      arm_log1 = create(:exercise_log, body_part_id: arm.id, user_id: user.id)
      arm_log2 = create(:exercise_log, body_part_id: arm.id, user_id: user.id)
      leg_log = create(:exercise_log, body_part_id: leg.id, user_id: user.id)

      expect(ExerciseLog.for_body_part(arm.id)).to include(arm_log1, arm_log2)
      expect(ExerciseLog.for_body_part(arm.id)).to_not include(leg_log)
    end
  end

  describe "self.group_by_exercise_and_count" do
    let!(:exercise1) { create(:exercise, :with_3_exercise_logs, name: "cross-body isometrics") }
    let!(:exercise2) { create(:exercise, :with_3_exercise_logs, name: "clam shells") }

    it "returns the exercise name and the count of its logs as a nested array" do
      expected_output = [["cross-body isometrics", 3], ["clam shells", 3]]
      expect(ExerciseLog.group_by_exercise_and_count).to match_array(expected_output)
    end
  end

  describe "self.minutes_spent_by_day" do
    it "returns a hash of dates and total minutes" do
      create(:exercise_log,
        occurred_at: "2019-12-30",
        sets: 1, reps: 1, rep_length: 120)

      create(:exercise_log,
        occurred_at: "2019-12-30",
        sets: 1, reps: 1, rep_length: 120)

      create(:exercise_log,
        occurred_at: "2019-12-31",
        sets: 1, reps: 1, rep_length: 60)

      expected_output = {
        "Mon, 30 Dec 2019".to_date => 4,
        "Tue, 31 Dec 2019".to_date => 1
      }

      expect(ExerciseLog.minutes_spent_by_day).to eq(expected_output)
    end
  end

  describe "#seconds_spent" do
    it "returns the total number of seconds_spent exercised per log" do
      exercise_log = build(:exercise_log, sets: 2, reps: 10, rep_length: 5)
      expect(exercise_log.seconds_spent).to eq(100)
    end

    it "doubles the value if per_side is true" do
      exercise_log = build(:exercise_log, sets: 2, reps: 10, rep_length: 5, per_side: true)
      expect(exercise_log.seconds_spent).to eq(200)
    end

    it "handles 0s gracefully" do
      exercise_log = build(:exercise_log, sets: 0, reps: 0, rep_length: 5)
      expect(exercise_log.seconds_spent).to eq(0)
    end
  end

  describe "#minutes_spent" do
    it "returns the total number of minutes_spent exercised per log" do
      exercise_log = build(:exercise_log)
      allow(exercise_log).to receive(:seconds_spent).and_return(120)

      expect(exercise_log.minutes_spent).to eq(2)
    end

    it "gracefully handles amounts less than 1 minute" do
      exercise_log = build(:exercise_log)
      allow(exercise_log).to receive(:seconds_spent).and_return(30)

      expect(exercise_log.minutes_spent).to eq(0.5)
    end
  end

  describe "#blank_stats?" do
    it "returns false if both sets and reps have values" do
      exercise_log = build(:exercise_log)
      allow(exercise_log).to receive(:sets).and_return(1)
      allow(exercise_log).to receive(:reps).and_return(2)

      expect(exercise_log.blank_stats?).to eq false
    end

    it "returns true if reps has a value and sets does not" do
      exercise_log = build(:exercise_log)
      allow(exercise_log).to receive(:sets).and_return("")
      allow(exercise_log).to receive(:reps).and_return(2)

      expect(exercise_log.blank_stats?).to eq true
    end

    it "returns true if sets has a value and reps does not" do
      exercise_log = build(:exercise_log)
      allow(exercise_log).to receive(:sets).and_return(1)
      allow(exercise_log).to receive(:reps).and_return("")

      expect(exercise_log.blank_stats?).to eq true
    end
  end
end
