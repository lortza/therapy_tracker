# frozen_string_literal: true

# == Schema Information
#
# Table name: survey_answer_options
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  value      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  survey_id  :uuid             not null
#
# Indexes
#
#  index_survey_answer_options_on_survey_id  (survey_id)
#
# Foreign Keys
#
#  fk_rails_...  (survey_id => surveys.id)
#
require "rails_helper"

RSpec.describe Survey::AnswerOption, type: :model do
  context "associations" do
    it { should belong_to(:survey) }
    it { should have_many(:answers).dependent(:destroy) }
  end

  context "validations" do
    it { should validate_presence_of(:value) }
    it { should validate_presence_of(:name) }

    describe "numericality" do
      subject { build(:survey_answer_option) }

      it { should validate_numericality_of(:value).only_integer.is_greater_than_or_equal_to(0) }
    end

    describe "uniqueness" do
      before { create(:survey_answer_option) } # Ensure there's an existing record for uniqueness validation

      it { should validate_uniqueness_of(:value).scoped_to(:survey_id) }
      it { should validate_uniqueness_of(:name).case_insensitive.scoped_to(:survey_id) }
    end
  end

  describe "text normalization" do
    it "strips leading/trailing whitespace and squishes internal blankspace before validation" do
      survey_answer_option = build(:survey_answer_option, name: "  Example    Option  ")
      expect(survey_answer_option.valid?).to be(true)
      expect(survey_answer_option.name).to eq("Example Option")
    end

    it "does not change any casing" do
      survey_answer_option = build(:survey_answer_option, name: "EXAMPLE option")
      expect(survey_answer_option.valid?).to be(true)
      expect(survey_answer_option.name).to eq("EXAMPLE option")
    end
  end
end
