# frozen_string_literal: true

# == Schema Information
#
# Table name: pain_logs
#
#  id               :bigint           not null, primary key
#  occurred_at      :datetime
#  pain_description :text             default("")
#  pain_level       :integer
#  trigger          :text             default("")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  body_part_id     :bigint
#  pain_id          :bigint
#  user_id          :bigint
#
# Indexes
#
#  index_pain_logs_on_body_part_id  (body_part_id)
#  index_pain_logs_on_occurred_at   (occurred_at)
#  index_pain_logs_on_pain_id       (pain_id)
#  index_pain_logs_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (body_part_id => body_parts.id)
#  fk_rails_...  (pain_id => pains.id)
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe PainLog, type: :model do
  context "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:pain) }
    it { should belong_to(:body_part) }
  end

  context "validations" do
    it { should validate_presence_of(:occurred_at) }
    it { should validate_presence_of(:body_part_id) }
    it { should validate_presence_of(:pain_id) }
    it { should validate_presence_of(:pain_level) }

    it { should validate_numericality_of(:pain_level) }
  end

  context "delegations" do
    it { should delegate_method(:name).to(:body_part).with_prefix }
    it { should delegate_method(:name).to(:pain).with_prefix }
  end

  context "attributes" do
    it "should have all of its attributes" do
      expected_attributes = %w[id
        body_part_id
        occurred_at
        pain_description
        pain_id
        pain_level
        trigger
        user_id
        created_at updated_at]
      actual_attributes = build(:pain_log).attributes.keys

      expect(actual_attributes).to match_array(expected_attributes)
    end
  end

  describe "self.for_past_n_days" do
    it "returns logs that occurred between today and the past n days" do
      pain_log = create(:pain_log, occurred_at: 2.days.ago)
      expect(PainLog.for_past_n_days(7)).to include(pain_log)
    end

    it "does not return logs that occurred outside of the past n days" do
      pain_log1 = create(:pain_log, occurred_at: 9.days.ago)
      pain_log2 = create(:pain_log, occurred_at: 2.days.from_now)

      expect(PainLog.for_past_n_days(7)).to_not include(pain_log1)
      expect(PainLog.for_past_n_days(7)).to_not include(pain_log2)
    end

    it "returns an empty array if no logs occurred within the past n days" do
      create(:pain_log, occurred_at: 9.days.ago)
      expect(PainLog.for_past_n_days(7)).to eq([])
    end
  end

  describe "self.for_body_part" do
    it "returns logs for the given body part" do
      user = create(:user)
      arm = create(:body_part, name: "arm", user_id: user.id)
      leg = create(:body_part, name: "leg", user_id: user.id)
      arm_log1 = create(:pain_log, body_part_id: arm.id, user_id: user.id)
      arm_log2 = create(:pain_log, body_part_id: arm.id, user_id: user.id)
      leg_log = create(:pain_log, body_part_id: leg.id, user_id: user.id)

      expect(PainLog.for_body_part(arm.id)).to include(arm_log1, arm_log2)
      expect(PainLog.for_body_part(arm.id)).to_not include(leg_log)
    end
  end
end
