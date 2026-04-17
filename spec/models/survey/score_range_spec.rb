# frozen_string_literal: true

# == Schema Information
#
# Table name: survey_score_ranges
#
#  id              :uuid             not null, primary key
#  name            :string
#  range_max_value :integer          not null
#  range_min_value :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  survey_id       :uuid             not null
#
# Indexes
#
#  index_survey_score_ranges_on_survey_id  (survey_id)
#
# Foreign Keys
#
#  fk_rails_...  (survey_id => surveys.id)
#
require "rails_helper"

RSpec.describe Survey::ScoreRange, type: :model do
  context "associations" do
    it { should belong_to(:survey) }
  end

  context "validations" do
    it { should validate_presence_of(:range_min_value) }
    it { should validate_presence_of(:range_max_value) }
    it { should validate_presence_of(:name) }

    describe "numericality" do
      subject { build(:survey_score_range, range_min_value: 0) } # Custom subject to guarantee presence of range_min_value for range_max_value validation

      it { should validate_numericality_of(:range_min_value).only_integer.is_greater_than_or_equal_to(0) }
      it { should validate_numericality_of(:range_max_value).only_integer.is_greater_than_or_equal_to(:range_min_value) }
    end

    describe "uniqueness" do
      before { create(:survey_score_range) } # Ensure there's an existing record for uniqueness validation

      it { should validate_uniqueness_of(:range_min_value).case_insensitive.scoped_to(:survey_id) }
      it { should validate_uniqueness_of(:range_max_value).case_insensitive.scoped_to(:survey_id) }
      it { should validate_uniqueness_of(:name).case_insensitive.scoped_to(:survey_id) }
    end
  end

  describe "text normalization" do
    it "strips leading/trailing whitespace and squishes internal blankspace before validation" do
      survey_score_range = build(:survey_score_range, name: "  Example    Range  ")
      expect(survey_score_range.valid?).to be(true)
      expect(survey_score_range.name).to eq("Example Range")
    end

    it "does not change any casing" do
      survey_score_range = build(:survey_score_range, name: "EXAMPLE range")
      expect(survey_score_range.valid?).to be(true)
      expect(survey_score_range.name).to eq("EXAMPLE range")
    end
  end
end
