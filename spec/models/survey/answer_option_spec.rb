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

  describe "scope: ordered" do
    it "orders by value, ascending" do
      survey = create(:survey)
      option_second = create(:survey_answer_option, survey: survey, value: 1)
      option_first = create(:survey_answer_option, survey: survey, value: 0)

      expect(Survey::AnswerOption.ordered).to eq([option_first, option_second])
    end
  end

  describe "callbacks" do
    describe "update_survey_question_min_and_max_point_values" do
      context "when this is the only answer option on the survey" do
        it "sets both the survey's min and max calculated_question_points to this answer_option's value" do
          survey = create(:survey)
          create(:survey_answer_option, survey: survey, value: 3, name: "Three")

          expect(survey.reload.calculated_question_min_points).to eq(3)
          expect(survey.reload.calculated_question_max_points).to eq(3)
        end
      end

      context "when adding an answer option lower than the existing minimum" do
        it "lowers the survey's calculated_question_min_points and leaves the max unchanged" do
          survey = create(:survey)
          create(:survey_answer_option, survey: survey, value: 5, name: "Five")
          create(:survey_answer_option, survey: survey, value: 2, name: "Two")

          expect(survey.reload.calculated_question_min_points).to eq(2)
          expect(survey.reload.calculated_question_max_points).to eq(5)
        end
      end

      context "when adding an answer option higher than the existing maximum" do
        it "raises the survey's calculated_question_max_points and leaves the min unchanged" do
          survey = create(:survey)
          create(:survey_answer_option, survey: survey, value: 1, name: "One")
          create(:survey_answer_option, survey: survey, value: 4, name: "Four")

          expect(survey.reload.calculated_question_min_points).to eq(1)
          expect(survey.reload.calculated_question_max_points).to eq(4)
        end
      end

      context "when adding an answer option between the existing min and max" do
        it "leaves the survey's calculated_question_min_points and calculated_question_max_points unchanged" do
          survey = create(:survey)
          create(:survey_answer_option, survey: survey, value: 1, name: "One")
          create(:survey_answer_option, survey: survey, value: 5, name: "Five")
          create(:survey_answer_option, survey: survey, value: 3, name: "Three")

          expect(survey.reload.calculated_question_min_points).to eq(1)
          expect(survey.reload.calculated_question_max_points).to eq(5)
        end
      end

      context "when destroying the answer option with the lowest value" do
        it "raises the survey's calculated_question_min_points to the next-lowest value" do
          survey = create(:survey)
          lowest = create(:survey_answer_option, survey: survey, value: 1, name: "One")
          create(:survey_answer_option, survey: survey, value: 3, name: "Three")
          create(:survey_answer_option, survey: survey, value: 5, name: "Five")

          lowest.destroy!

          expect(survey.reload.calculated_question_min_points).to eq(3)
          expect(survey.reload.calculated_question_max_points).to eq(5)
        end
      end

      context "when destroying the answer option with the highest value" do
        it "lowers the survey's calculated_question_max_points to the next-highest value" do
          survey = create(:survey)
          create(:survey_answer_option, survey: survey, value: 1, name: "One")
          create(:survey_answer_option, survey: survey, value: 3, name: "Three")
          highest = create(:survey_answer_option, survey: survey, value: 5, name: "Five")

          highest.destroy!

          expect(survey.reload.calculated_question_min_points).to eq(1)
          expect(survey.reload.calculated_question_max_points).to eq(3)
        end
      end

      context "when destroying the only answer option on the survey" do
        it "sets both the survey's calculated_question_min_points and calculated_question_max_points to nil" do
          survey = create(:survey)
          option = create(:survey_answer_option, survey: survey, value: 3, name: "Three")

          option.destroy!

          expect(survey.reload.calculated_question_min_points).to be_nil
          expect(survey.reload.calculated_question_max_points).to be_nil
        end
      end
    end
  end
end
