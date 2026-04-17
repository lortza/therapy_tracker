# frozen_string_literal: true

# == Schema Information
#
# Table name: survey_categories
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  position   :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  survey_id  :uuid             not null
#
# Indexes
#
#  index_survey_categories_on_survey_id  (survey_id)
#
# Foreign Keys
#
#  fk_rails_...  (survey_id => surveys.id)
#
require "rails_helper"

RSpec.describe Survey::Category, type: :model do
  context "associations" do
    it { should belong_to(:survey) }
    it { should have_many(:questions).dependent(:destroy) }
  end

  context "validations" do
    before { create(:survey_category) } # Ensure there's an existing record for uniqueness validation
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
