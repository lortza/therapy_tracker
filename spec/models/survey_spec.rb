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
    it { should belong_to(:user).optional(true) }
    it { should have_many(:categories).dependent(:destroy) }
    it { should have_many(:questions).through(:categories) }
    it { should have_many(:answer_options).dependent(:destroy) }
    it { should have_many(:score_ranges).dependent(:destroy) }
    it { should have_many(:enrollments).dependent(:destroy) }
    it { should have_many(:users).through(:enrollments) }
    it { should have_many(:responses).dependent(:destroy) }
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
