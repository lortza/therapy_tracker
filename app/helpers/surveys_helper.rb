# frozen_string_literal: true

module SurveysHelper
  def display_score_range_steps?(survey)
    allowed_to?(:edit?, survey) &&
      survey.questions.any? &&
      survey.answer_options.presence &&
      survey.answer_options.maximum(:value) > 0
  end
end
