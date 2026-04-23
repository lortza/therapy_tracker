# frozen_string_literal: true

class Survey::ResponseDecorator < ApplicationDecorator
  delegate_all

  def display_name
    survey.name
  end

  def icon_name
    "psychology_alt"
  end

  def css_name
    "survey"
  end

  def score_name
    score_range_step&.name&.titleize
  end

  def score_description
    score_range_step&.description
  end

  def difference_from_previous_response
    return nil unless previous_response

    points = total_score - previous_response.total_score
    case points
    when 0
      "No change from previous response"
    else
      "#{"+" if points > 0}#{points} from previous response"
    end

    if points == 0
      "No change from previous response"
    elsif points > 0
      "+#{points} from previous response ☹️"
    else
      "#{points} from previous response 😀"
    end
  end
end
