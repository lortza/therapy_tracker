# frozen_string_literal: true

# == Schema Information
#
# Table name: survey_score_range_steps
#
#  id                          :uuid             not null, primary key
#  calculated_range_max_points :integer
#  calculated_range_min_points :integer
#  description                 :text
#  name                        :string           not null
#  position                    :integer          not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  survey_id                   :uuid             not null
#
# Indexes
#
#  index_survey_score_range_steps_on_survey_id  (survey_id)
#
# Foreign Keys
#
#  fk_rails_...  (survey_id => surveys.id)
#
require "rails_helper"

RSpec.describe Survey::ScoreRangeStep, type: :model do
  context "associations" do
    it { should belong_to(:survey) }
  end

  context "validations" do
    describe "presence" do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:position) }
    end

    describe "numericality" do
      subject { build(:survey_score_range_step, calculated_range_min_points: 0) } # Custom subject to guarantee presence of calculated_range_min_points for calculated_range_max_points validation

      it { should validate_numericality_of(:position).only_integer.is_greater_than_or_equal_to(0) }
      it { should validate_numericality_of(:calculated_range_min_points).only_integer.is_greater_than_or_equal_to(0) }
      it { should validate_numericality_of(:calculated_range_max_points).only_integer.is_greater_than_or_equal_to(:calculated_range_min_points) }
    end

    describe "uniqueness" do
      before { create(:survey_score_range_step, calculated_range_min_points: 0) } # Ensure there's an existing record for uniqueness validation

      it { should validate_uniqueness_of(:position).scoped_to(:survey_id) }
      it { should validate_uniqueness_of(:calculated_range_min_points).scoped_to(:survey_id) }
      it { should validate_uniqueness_of(:calculated_range_max_points).scoped_to(:survey_id) }
      it { should validate_uniqueness_of(:name).case_insensitive.scoped_to(:survey_id) }
    end
  end

  describe "text normalization" do
    it "strips leading/trailing whitespace and squishes internal blankspace before validation" do
      survey_score_range_step = build(:survey_score_range_step, name: "  Example    Range  ")
      expect(survey_score_range_step.valid?).to be(true)
      expect(survey_score_range_step.name).to eq("Example Range")
    end

    it "does not change any casing" do
      survey_score_range_step = build(:survey_score_range_step, name: "EXAMPLE range")
      expect(survey_score_range_step.valid?).to be(true)
      expect(survey_score_range_step.name).to eq("EXAMPLE range")
    end
  end

  describe "scope: ordered" do
    it "orders score range steps by position in ascending order" do
      survey = create(:survey)
      step_b = create(:survey_score_range_step, survey: survey, position: 1)
      step_a = create(:survey_score_range_step, survey: survey, position: 0)

      expect(Survey::ScoreRangeStep.ordered).to eq([step_a, step_b])
    end
  end
end
