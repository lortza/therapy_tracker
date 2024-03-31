# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'associations' do
    it { should have_many(:body_parts) }
    it { should have_many(:exercises) }
    it { should have_many(:exercise_logs) }
    it { should have_many(:pains) }
    it { should have_many(:pain_logs) }
    it { should have_many(:pt_session_logs) }
    it { should have_many(:slit_logs) }
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
                               enable_slit_tracking
                               enable_pt_session_tracking
                               created_at
                               updated_at]
      actual_attributes = build(:user).attributes.keys

      expect(actual_attributes).to match_array(expected_attributes)
    end
  end

  describe 'scopes' do
    describe 'with_slit_enabled' do
      let(:user_with_slit_tracking) { create(:user, enable_slit_tracking: true) }
      let(:user_without_slit_tracking) { create(:user, enable_slit_tracking: false) }

      before do
        user_with_slit_tracking
        user_without_slit_tracking
      end

      it 'includes users with slit_tracking_enabled' do
        expect(described_class.with_slit_enabled).to include(user_with_slit_tracking)
      end

      it 'excludes users without slit_tracking_enabled' do
        expect(described_class.with_slit_enabled).not_to include(user_without_slit_tracking)
      end
    end
  end

  describe '#full_name' do
    it 'displays the users full name' do
      user = build(:user, first_name: 'first', last_name: 'last')
      expect(user.full_name).to eq('first last')
    end
  end
end
