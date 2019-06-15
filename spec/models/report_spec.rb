# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Report, type: :model do
  context 'attributes' do
    it 'should have all of its attributes' do
      expected_attributes = %w[filter_params]
      actual_attributes = build(:report).attributes.keys

      expect(actual_attributes).to match_array(expected_attributes)
    end
  end
end
