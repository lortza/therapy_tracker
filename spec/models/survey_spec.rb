# frozen_string_literal: true

# == Schema Information
#
# Table name: surveys
#
#  id                             :uuid             not null, primary key
#  available_to_public            :boolean          default(FALSE), not null
#  calculated_question_max_points :integer
#  calculated_question_min_points :integer
#  description                    :text
#  instructions                   :text
#  name                           :string           not null
#  status                         :integer          default("draft"), not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  user_id                        :bigint
#
# Indexes
#
#  index_surveys_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe Survey, type: :model do
  context "associations" do
    it { should belong_to(:author).optional(true) }
    it { should have_many(:categories).dependent(:destroy) }
    it { should have_many(:questions).through(:categories) }
    it { should have_many(:answer_options).dependent(:destroy) }
    it { should have_many(:score_range_steps).dependent(:destroy) }
    it { should have_many(:enrollments).dependent(:destroy) }
    it { should have_many(:enrolled_users).through(:enrollments) }
    it { should have_many(:responses).dependent(:destroy) }
  end

  context "validations" do
    describe "presence" do
      it { should validate_presence_of(:name) }
    end

    describe "uniqueness" do
      before { create(:survey) } # Ensure there's an existing survey for uniqueness validation
      it { should validate_uniqueness_of(:name).case_insensitive }
    end

    describe "numericality" do
      subject { build(:survey, calculated_question_min_points: 0) } # Custom subject to guarantee presence of calculated_question_min_points for calculated_question_max_points validation

      it { should validate_numericality_of(:calculated_question_min_points).only_integer.is_greater_than_or_equal_to(0) }
      it { should validate_numericality_of(:calculated_question_max_points).only_integer.is_greater_than_or_equal_to(:calculated_question_min_points) }
    end
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

  describe "scope: available_to_public" do
    let(:subject) { Survey.available_to_public }

    it "returns only surveys where available_to_public is true" do
      available_survey = create(:survey, available_to_public: true)
      unavailable_survey = create(:survey, available_to_public: false)

      expect(subject).to eq([available_survey])
      expect(subject).not_to include(unavailable_survey)
    end
  end

  describe "max_score" do
    it "returns the maximum possible score for the survey" do
      survey = create(:survey, calculated_question_min_points: 0, calculated_question_max_points: 5)
      category = create(:survey_category, survey: survey)
      create_list(:survey_question, 3, category: category)

      expect(survey.max_score).to eq(15) # 3 questions * 5 points each
    end

    it "returns nil when calculated_question_max_points has not been set" do
      survey = create(:survey)
      expect(survey.max_score).to be_nil
    end
  end

  describe "calculate_score_range_steps_points!" do
    let(:survey) { create(:survey) }
    let(:survey_category) { create(:survey_category, survey: survey) }

    it "assigns min and max points to each of the survey's score_range_steps" do
      5.times { |v| create(:survey_answer_option, survey: survey, value: v, name: "Option #{v}") } # Creates values 0-4
      create_list(:survey_question, 5, category: survey_category) # 5 questions * max 4 points each = max score of 20 for the survey
      create_list(:survey_score_range_step, 3, survey: survey) # makes a score range step of 7 points each

      # Check that the setup has given us the expected conditions for the test
      expect(survey.calculated_question_min_points).to eq(0)
      expect(survey.calculated_question_max_points).to eq(4)
      expect(survey.max_score).to eq(20)
      expect(survey.score_range_steps.length).to eq(3)

      # Call the method under test
      survey.reload
      survey.calculate_score_range_steps_points!

      expect(survey.score_range_steps.first.calculated_range_min_points).to eq(0)
      expect(survey.score_range_steps.first.calculated_range_max_points).to eq(6)

      expect(survey.score_range_steps.second.calculated_range_min_points).to eq(7)
      expect(survey.score_range_steps.second.calculated_range_max_points).to eq(13)

      expect(survey.score_range_steps.third.calculated_range_min_points).to eq(14)
      expect(survey.score_range_steps.third.calculated_range_max_points).to eq(20)
    end

    it "returns nil if there are no score range steps" do
      5.times { |v| create(:survey_answer_option, survey: survey, value: v, name: "Option #{v}") } # Creates values 0-4
      create_list(:survey_question, 5, category: survey_category) # 5 questions * max 4 points each = max score of 20 for the survey

      survey.score_range_steps.destroy_all
      expect(survey.calculate_score_range_steps_points!).to be_nil
    end

    it "returns nil if there the survey has no max score" do
      5.times { |v| create(:survey_answer_option, survey: survey, value: v, name: "Option #{v}") } # Creates values 0-4
      create_list(:survey_question, 5, category: survey_category) # 5 questions * max 4 points each = max score of 20 for the survey
      allow(survey).to receive(:max_score).and_return(nil)
      expect(survey.calculate_score_range_steps_points!).to be_nil
    end

    context "when the available points for the survey is not evenly divisible by the number of score range steps" do
      before do
        4.times { |v| create(:survey_answer_option, survey: survey, value: v, name: "Option #{v}") } # Creates values 0-3
        create_list(:survey_question, 7, category: survey_category) # 7 questions * max 3 points each = max score of 21 for the survey
        create_list(:survey_score_range_step, 4, survey: survey) # makes a score range step of 5.5 points each, with 1 point left over
      end

      it "SETUP CHECK: Check that the setup has given us the expected conditions for the test" do
        expect(survey.calculated_question_min_points).to eq(0)
        expect(survey.calculated_question_max_points).to eq(3)
        expect(survey.max_score).to eq(21)
        expect(survey.score_range_steps.length).to eq(4)
      end

      it "divides the remainder amongst the first few range steps" do
        survey.calculate_score_range_steps_points!

        first_step_distance = (survey.score_range_steps.first.calculated_range_min_points..survey.score_range_steps.first.calculated_range_max_points).to_a.length
        expect(first_step_distance).to eq(6) # 5 base points + 1 extra point from the remainder

        second_step_distance = (survey.score_range_steps.second.calculated_range_min_points..survey.score_range_steps.second.calculated_range_max_points).to_a.length
        expect(second_step_distance).to eq(6) # 5 base points + 1 extra point from the remainder

        third_step_distance = (survey.score_range_steps.third.calculated_range_min_points..survey.score_range_steps.third.calculated_range_max_points).to_a.length
        expect(third_step_distance).to eq(5) # 5 base points
      end

      it "ensures the survey_max_score is the calculated_range_max_points for the last score range step" do
        survey.calculate_score_range_steps_points!
        survey.reload
        expect(survey.score_range_steps.last.calculated_range_max_points).to eq(survey.max_score)
      end

      it "assigns min and max points to each of the survey's score_range_steps" do
        survey.reload
        survey.calculate_score_range_steps_points!

        expect(survey.score_range_steps[0].calculated_range_min_points).to eq(0)
        expect(survey.score_range_steps[0].calculated_range_max_points).to eq(5)

        expect(survey.score_range_steps[1].calculated_range_min_points).to eq(6)
        expect(survey.score_range_steps[1].calculated_range_max_points).to eq(11)

        expect(survey.score_range_steps[2].calculated_range_min_points).to eq(12)
        expect(survey.score_range_steps[2].calculated_range_max_points).to eq(16)

        expect(survey.score_range_steps[-1].calculated_range_min_points).to eq(17)
        expect(survey.score_range_steps[-1].calculated_range_max_points).to eq(21)
      end
    end
  end

  describe "calculate_min_and_max_points!" do
    let(:survey) { create(:survey) }

    it "sets calculated_question_min_points from the minimum answer option value" do
      create(:survey_answer_option, survey: survey, value: 1, name: "Never")
      create(:survey_answer_option, survey: survey, value: 2, name: "Sometimes")
      create(:survey_answer_option, survey: survey, value: 3, name: "Always")
      survey.calculate_min_and_max_points!
      expect(survey.reload.calculated_question_min_points).to eq(1)
    end

    it "sets calculated_question_max_points from the maximum answer option value" do
      create(:survey_answer_option, survey: survey, value: 1, name: "Never")
      create(:survey_answer_option, survey: survey, value: 2, name: "Sometimes")
      create(:survey_answer_option, survey: survey, value: 3, name: "Always")
      survey.calculate_min_and_max_points!
      expect(survey.reload.calculated_question_max_points).to eq(3)
    end
  end
end
