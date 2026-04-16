# frozen_string_literal: true

require "rails_helper"

RSpec.describe Survey, type: :model do
  context "associations" do
    it { should have_many(:survey_responses) }
    it { should have_many(:questions).through(:survey_categories) }
    it { should have_many(:survey_answer_options) }
    it { should have_many(:survey_score_ranges) }
    it { should have_many(:survey_enrollments) }
    it { should have_many(:users).through(:survey_enrollments) }
    it { should have_many(:survey_responses) }
  end

  context "validations" do
    before { create(:survey) } # Ensure there's an existing survey for uniqueness validation
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe "name normalization" do
    it "strips leading/trailing whitespace and squishes internal blankspace before validation" do
      survey = build(:survey, name: "  Example    Survey  ")
      expect(survey.valid?).to be(true)
      expect(survey.name).to eq("Example Survey")
    end

    it "does not change any casing" do
      survey = build(:survey, name: "EXAMPLE survey")
      expect(survey.valid?).to be(true)
      expect(survey.name).to eq("EXAMPLE survey")
    end
  end
end
