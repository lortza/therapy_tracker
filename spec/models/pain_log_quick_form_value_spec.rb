# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PainLogQuickFormValue, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:pain) }
    it { should belong_to(:body_part) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:pain_level) }
  end

  describe 'case insensitivity of "name" scoped to record owner' do
    it 'does not permit the owner to give two records the same name' do
      user = create(:user)
      create(:pain_log_quick_form_value, user: user, name: 'foo')
      duplicate_record = build(:pain_log_quick_form_value, user: user, name: 'FOO')
      expect(duplicate_record.valid?).to be(false)
    end

    it 'permits multiple users to have records with the same name' do
      create(:pain_log_quick_form_value, name: 'foo')
      duplicate_record = build(:pain_log_quick_form_value, name: 'foo')
      expect(duplicate_record.valid?).to be(true)
    end
  end

  describe 'loggable_attributes' do
    it 'contains only the attributes needed by a pain_log object' do
      expected_keys = [
        'user_id',
        'body_part_id',
        'pain_id',
        'pain_level',
        'pain_description',
        'trigger',
        :datetime_occurred,
      ]
      quick_log = build(:pain_log_quick_form_value)
      actual_keys = quick_log.loggable_attributes.keys

      expect(actual_keys).to match_array(expected_keys)
    end

    it 'should have a value for datetime_occurred' do
      quick_log = build(:pain_log_quick_form_value)
      datetime_occurred = quick_log.loggable_attributes[:datetime_occurred]

      expect(datetime_occurred).to be
    end
  end
end
