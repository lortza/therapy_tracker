# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'associations' do
    it { should have_many(:body_parts) }
    it { should have_many(:exercises) }
    it { should have_many(:exercise_logs) }
    it { should have_many(:pains) }
    it { should have_many(:pain_logs) }
    it { should have_many(:pt_sessions) }
  end

  context 'attributes' do
    it 'should have all of its attributes' do
      expected_attributes = %w[id
                               email
                               encrypted_password
                               reset_password_token
                               reset_password_sent_at
                               remember_created_at
                               first_name
                               last_name
                               admin
                               created_at updated_at]
      actual_attributes = build(:user).attributes.keys

      expect(expected_attributes).to match_array(actual_attributes)
    end
  end

  describe '#full_name' do
    it 'displays the users full name' do
      user = build(:user, first_name: 'first', last_name: 'last')
      expect(user.full_name).to eq('first last')
    end
  end
end
