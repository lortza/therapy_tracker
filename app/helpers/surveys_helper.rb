# frozen_string_literal: true

module SurveysHelper
  def display_score_range_steps?(survey)
    allowed_to?(:edit?, survey) && survey.questions.any?
  end
end
