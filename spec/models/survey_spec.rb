# frozen_string_literal: true

# == Schema Information
#
# Table name: surveys
#
#  id                  :uuid             not null, primary key
#  available_to_public :boolean          default(FALSE), not null
#  description         :text
#  name                :string           not null
#  published           :boolean          default(FALSE), not null
#  question_max_points :integer          not null
#  question_min_points :integer          default(0), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :bigint
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
      it { should validate_presence_of(:question_max_points) }
      it { should validate_presence_of(:question_min_points) }
      it { should validate_presence_of(:name) }
    end

    describe "uniqueness" do
      before { create(:survey) } # Ensure there's an existing survey for uniqueness validation
      it { should validate_uniqueness_of(:name).case_insensitive }
    end

    describe "numericality" do
      subject { build(:survey, question_min_points: 0) } # Custom subject to guarantee presence of question_min_points for question_max_points validation

      it { should validate_numericality_of(:question_min_points).only_integer.is_greater_than_or_equal_to(0) }
      it { should validate_numericality_of(:question_max_points).only_integer.is_greater_than_or_equal_to(:question_min_points) }
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

  describe "scope: published" do
    let(:subject) { Survey.published }

    it "returns only surveys where published is true" do
      published_survey = create(:survey, published: true)
      unpublished_survey = create(:survey, published: false)

      expect(subject).to eq([published_survey])
      expect(subject).not_to include(unpublished_survey)
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
      survey = create(:survey, question_min_points: 0, question_max_points: 5)
      category = create(:survey_category, survey: survey)
      create_list(:survey_question, 3, category: category)

      expect(survey.max_score).to eq(15) # 3 questions * 5 points each
    end
  end
end
