# frozen_string_literal: true

# == Schema Information
#
# Table name: survey_enrollments
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  survey_id  :uuid             not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_survey_enrollments_on_survey_id              (survey_id)
#  index_survey_enrollments_on_user_id                (user_id)
#  index_survey_enrollments_on_user_id_and_survey_id  (user_id,survey_id)
#
# Foreign Keys
#
#  fk_rails_...  (survey_id => surveys.id)
#  fk_rails_...  (user_id => users.id)
#
class Survey::Enrollment < ApplicationRecord
  # A Survey::Enrollment is the means by which a user opts in to the survey feature in the app.
  # It represents a user's enrollment in a specific survey. A user can be enrolled in multiple surveys,
  # and a survey can have multiple enrolled users.

  belongs_to :survey
  belongs_to :user
end
