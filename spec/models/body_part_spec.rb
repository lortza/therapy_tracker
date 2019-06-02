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
    it { should validate_uniqueness_of(:name).case_insensitive.scoped_to(:user_id) }
  end

  context 'attributes' do
    it 'should have all of its attributes' do
      expected_attributes = %w[id
                               archived
                               name
                               user_id
                               created_at updated_at]
      actual_attributes = build(:body_part).attributes.keys

      expect(actual_attributes).to match_array(expected_attributes)
    end
  end


    end
  end

  describe 'self.by_name' do
    it 'returns a list of body_parts ordered by name, ascending' do
      body_part1 = create(:body_part, name: 'a')
      body_part2 = create(:body_part, name: 'b')
      body_part3 = create(:body_part, name: 'c')

      expect(BodyPart.by_name).to match_array([body_part1, body_part2, body_part3])
    end
  end

  describe 'self.search()' do
    let!(:body_part1) { create(:body_part, name: 'body_part1') }
    let!(:body_part2) { create(:body_part, name: 'body_part2') }

    it 'returns all body_parts if no argument is supplied' do
      terms = ''
      expect(BodyPart.search(terms).count).to eq(2)
    end

    it 'returns all matches for partial string matches' do
      terms = 'bod'
      expect(BodyPart.search(terms).count).to eq(2)
    end

    it 'excludes items that have characters that are not included' do
      terms = 'art1'
      expect(BodyPart.search(terms).count).to eq(1)
      expect(BodyPart.search(terms)).to include(body_part1)
      expect(BodyPart.search(terms)).to_not include(body_part2)
    end

    it 'returns an empty array if there are no matches' do
      terms = 'x'
      expect(BodyPart.search(terms)).to eq([])
    end
  end
end
