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

  describe '#full_name' do
    it 'displays the users full name' do
      user = build(:user, first_name: 'first', last_name: 'last')
      expect(user.full_name).to eq('first last')
    end
  end
end
