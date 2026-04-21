# frozen_string_literal: true

# == Schema Information
#
# Table name: survey_questions
#
#  id                 :uuid             not null, primary key
#  position           :integer          default(0), not null
#  text               :text             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  survey_category_id :uuid             not null
#
# Indexes
#
#  index_survey_questions_on_survey_category_id  (survey_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (survey_category_id => survey_categories.id)
#
require "rails_helper"

RSpec.describe Survey::Question, type: :model do
  context "associations" do
    it { should belong_to(:category) }
    it { should delegate_method(:survey).to(:category) }
    it { should have_many(:answers).dependent(:destroy) }
  end

  context "validations" do
    before { create(:survey_question) } # Ensure there's an existing record for uniqueness validation
    it { should validate_presence_of(:position) }
    it { should validate_numericality_of(:position).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_presence_of(:text) }
    it { should validate_uniqueness_of(:text).case_insensitive.scoped_to(:survey_category_id) }
  end

  describe "text normalization" do
    it "strips leading/trailing whitespace and squishes internal blankspace before validation" do
      survey_question = build(:survey_question, text: "  Example    Question  ")
      expect(survey_question.valid?).to be(true)
      expect(survey_question.text).to eq("Example Question")
    end

    it "does not change any casing" do
      survey_question = build(:survey_question, text: "EXAMPLE question")
      expect(survey_question.valid?).to be(true)
      expect(survey_question.text).to eq("EXAMPLE question")
    end
  end

  describe "scope: ordered" do
    it "returns a collection of questions ordered by category position then question position" do
      survey = create(:survey)
      category_first = create(:survey_category, survey: survey, position: 0)
      category_second = create(:survey_category, survey: survey, position: 1)

      question_c = create(:survey_question, category: category_second, position: 0)
      question_b = create(:survey_question, category: category_first, position: 1)
      question_a = create(:survey_question, category: category_first, position: 0)

      expect(Survey::Question.ordered).to eq([question_a, question_b, question_c])
    end
  end
end
