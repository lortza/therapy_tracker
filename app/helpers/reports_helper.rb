# frozen_string_literal: true

module ReportsHelper
  def avg_pain_level(occurrences)
    (occurrences.map(&:pain_level).sum / occurrences.length).to_i
  end
end
