# frozen_string_literal: true

module SurveysHelper
  def display_score_range_steps?(survey)
    survey.questions.any? &&
      survey.answer_options.presence &&
      survey.answer_options.maximum(:value) > 0
  end

  def difference_from_previous_response_score(current_response)
    previous_response = current_response.previous_response
    return 0 unless previous_response

    current_response.total_score - previous_response.total_score
  end
end
