# frozen_string_literal: true

module ReportsHelper
  def avg_pain_level(occurrences)
    OccurrenceCalculator.new(occurrences).avg_pain_level
  end

  def occurrence_timeframe(occurrences)
    timeframe = OccurrenceCalculator.new(occurrences).timeframe
    pluralize(timeframe.qty, timeframe.unit)
  end

  def occurrence_frequency(occurrences)
    OccurrenceCalculator.new(occurrences).frequency
  end

  def formatted_first_occurrence_datetime(occurrences)
    format_datetime(OccurrenceCalculator.new(occurrences).first_datetime)
  end

  def formatted_last_occurrence_datetime(occurrences)
    format_datetime(OccurrenceCalculator.new(occurrences).last_datetime)
  end
end
