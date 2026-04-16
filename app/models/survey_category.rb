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
class SurveyCategory < ApplicationRecord
  # Only Admins edit this table
  # A SurveyCategory is a way to group related questions within a survey. For example, a
  # "Depression Survey" might have categories like "Feelings" and "Physical Symptoms",
  # Each category would then have specific questions related to that category.

  belongs_to :survey
  has_many :survey_questions, dependent: :destroy

  normalizes :name, with: ->(name) { name.strip.squish }
  validates :name,
    presence: true,
    uniqueness: {scope: :survey_id, case_sensitive: false}

  validates :position,
    presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: 0}
end
