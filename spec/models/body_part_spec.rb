# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BodyPart, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:pain_logs) }
    it { should have_many(:exercise_logs) }
    it { should have_many(:pt_sessions) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
