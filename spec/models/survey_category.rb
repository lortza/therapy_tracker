# frozen_string_literal: true

require "rails_helper"

RSpec.describe SurveyCategory, type: :model do
  context "associations" do
    it { should belong_to(:survey) }
    it { should have_many(:survey_questions).dependent(:destroy) }
  end

  context "validations" do
    before { create(:survey_category) } # Ensure there's an existing survey for uniqueness validation
    it { should validate_presence_of(:position) }
    it { should validate_numericality_of(:position).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive.scoped_to(:survey_id) }
  end

  describe "name normalization" do
    it "strips leading/trailing whitespace and squishes internal blankspace before validation" do
      survey_category = build(:survey_category, name: "  Example    Category  ")
      expect(survey_category.valid?).to be(true)
      expect(survey_category.name).to eq("Example Category")
    end

    it "does not change any casing" do
      survey_category = build(:survey_category, name: "EXAMPLE category")
      expect(survey_category.valid?).to be(true)
      expect(survey_category.name).to eq("EXAMPLE category")
    end
  end
end
