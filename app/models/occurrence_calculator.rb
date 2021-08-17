# frozen_string_literal: true

class OccurrenceCalculator
  attr_reader :occurrences

  def initialize(occurrences)
    @occurrences = occurrences
  end

  def avg_pain_level
    (pain_levels.sum / occurrences.length).to_i
  end

  def frequency
    occurrence_qty = occurrences.length
    if occurrence_qty == 1
      'once'
    elsif occurrence_qty >= timeframe.qty
      qty = (occurrence_qty / timeframe.qty).round(1)
      "#{qty} per #{timeframe.unit}"
    else
      qty = (timeframe.qty / occurrence_qty).round(1)
      "#{qty} per #{timeframe.unit}"
    end
  end

  # rubocop:disable Metrics/MethodLength
  def timeframe
    seconds = last_datetime - first_datetime
    days = (seconds / 60 / 60 / 24)
    data = OpenStruct.new
    if days.zero?
      data.qty = 1.round(1)
      data.unit = 'day'
    elsif days < 7
      data.qty = days.round(1)
      data.unit = 'day'
    elsif days < 30
      data.qty = (days / 7).round(1)
      data.unit = 'week'
    elsif days < 360
      data.qty = (days / 30).round(1)
      data.unit = 'month'
    else
      data.qty = (days / 360).round(1)
      data.unit = 'year'
    end
    data
  end
  # rubocop:enable Metrics/MethodLength

  def first_datetime
    datetimes.min
  end

  def last_datetime
    datetimes.max
  end

  private

  def datetimes
    occurrences.map(&:datetime_occurred)
  end

  def pain_levels
    occurrences.map(&:pain_level)
  end
end
