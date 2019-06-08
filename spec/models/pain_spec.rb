# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pain, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:pain_logs) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive.scoped_to(:user_id) }
  end

  context 'attributes' do
    it 'should have all of its attributes' do
      expected_attributes = %w[id
                               name
                               user_id
                               created_at updated_at]
      actual_attributes = build(:pain).attributes.keys

      expect(actual_attributes).to match_array(expected_attributes)
    end
  end

  describe 'self.logs?' do
    it 'returns all pains that have logs' do
      pain = create(:pain, :with_3_pain_logs)
      expect(Pain.logs?).to include(pain)
    end

    it 'does not include pains that do not have logs' do
      pain = create(:pain)
      expect(Pain.logs?).not_to include(pain)
    end
  end

  describe 'self.log_count_by_name' do
    let!(:pain1) { create(:pain, :with_3_pain_logs, name: 'pain1') }
    let!(:pain2) { create(:pain, :with_3_pain_logs, name: 'pain2') }

    it 'returns the pain name and the count of its logs as a nested array' do
      expected_output = [['pain1', 3], ['pain2', 3]]
      expect(Pain.log_count_by_name).to match_array(expected_output)
    end
  end

  describe 'self.by_name' do
    it 'returns a list of pains ordered by name, ascending' do
      pain1 = create(:pain, name: 'a')
      pain2 = create(:pain, name: 'b')
      pain3 = create(:pain, name: 'c')

      expect(Pain.by_name).to match_array([pain1, pain2, pain3])
    end
  end

  describe 'self.search()' do
    let!(:pain1) { create(:pain, name: 'pain1') }
    let!(:pain2) { create(:pain, name: 'pain2') }

    it 'returns all pains if no argument is supplied' do
      terms = ''
      expect(Pain.search(terms).count).to eq(2)
    end

    it 'returns all matches for partial string matches' do
      terms = 'pai'
      expect(Pain.search(terms).count).to eq(2)
    end

    it 'excludes items that have characters that are not included' do
      terms = 'n1'
      expect(Pain.search(terms).count).to eq(1)
      expect(Pain.search(terms)).to include(pain1)
      expect(Pain.search(terms)).to_not include(pain2)
    end

    it 'returns an empty array if there are no matches' do
      terms = 'x'
      expect(Pain.search(terms)).to eq([])
    end
  end
end
