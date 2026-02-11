# == Schema Information
#
# Table name: pain_log_quick_form_values
#
#  id               :bigint           not null, primary key
#  name             :string           not null
#  pain_description :text
#  pain_level       :integer
#  trigger          :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  body_part_id     :bigint
#  pain_id          :bigint
#  user_id          :bigint
#
# Indexes
#
#  index_pain_log_quick_form_values_on_body_part_id  (body_part_id)
#  index_pain_log_quick_form_values_on_pain_id       (pain_id)
#  index_pain_log_quick_form_values_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (body_part_id => body_parts.id)
#  fk_rails_...  (pain_id => pains.id)
#  fk_rails_...  (user_id => users.id)
#

# frozen_string_literal: true

require "rails_helper"

RSpec.describe PainLogQuickFormValue, type: :model do
  context "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:pain) }
    it { should belong_to(:body_part) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:pain_level) }
  end

  describe 'case insensitivity of "name" scoped to record owner' do
    it "does not permit the owner to give two records the same name" do
      user = create(:user)
      create(:pain_log_quick_form_value, user: user, name: "foo")
      duplicate_record = build(:pain_log_quick_form_value, user: user, name: "FOO")
      expect(duplicate_record.valid?).to be(false)
    end

    it "permits multiple users to have records with the same name" do
      create(:pain_log_quick_form_value, name: "foo")
      duplicate_record = build(:pain_log_quick_form_value, name: "foo")
      expect(duplicate_record.valid?).to be(true)
    end
  end

  describe "loggable_attributes" do
    it "contains only the attributes needed by a pain_log object" do
      expected_keys = [
        "user_id",
        "body_part_id",
        "pain_id",
        "pain_level",
        "pain_description",
        "trigger",
        :occurred_at
      ]
      quick_log = build(:pain_log_quick_form_value)
      actual_keys = quick_log.loggable_attributes.keys

      expect(actual_keys).to match_array(expected_keys)
    end

    it "should have a value for occurred_at" do
      quick_log = build(:pain_log_quick_form_value)
      occurred_at = quick_log.loggable_attributes[:occurred_at]

      expect(occurred_at).to be
    end
  end
end
