# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SlitLog, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
  end

  context 'validations' do
    it { should validate_presence_of(:datetime_occurred) }
  end
end
