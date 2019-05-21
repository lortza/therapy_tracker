# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PtHomeworkExercise, type: :model do
  context 'associations' do
    it { should belong_to(:pt_session) }
    it { should belong_to(:exercise) }
  end

  context 'validations' do
    it { should validate_presence_of(:pt_session) }
    it { should validate_presence_of(:exercise) }
  end
end
