# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReportsHelper, type: :helper do
  let(:occurrences) { 'foo' }

  describe 'avg_pain_level' do
    it 'calls the OccurrenceCalculator' do
      expect_any_instance_of(OccurrenceCalculator).to receive(:avg_pain_level).and_return('foo')

      helper.avg_pain_level(occurrences)
    end

    it 'returns the average pain level for a set of logs' do
      allow_any_instance_of(OccurrenceCalculator).to receive(:avg_pain_level).and_return(2.5)

      expect(helper.avg_pain_level(occurrences)).to eq(2.5)
    end
  end

  describe 'occurrence_frequency' do
    it 'calls the OccurrenceCalculator' do
      expect_any_instance_of(OccurrenceCalculator).to receive(:frequency)

      helper.occurrence_frequency(occurrences)
    end

    it 'returns the frequency as sent by the OccurrenceCalculator' do
      allow_any_instance_of(OccurrenceCalculator).to receive(:frequency).and_return('1.6 per week')

      expect(helper.occurrence_frequency(occurrences)).to eq('1.6 per week')
    end
  end

  describe 'occurrence_timeframe' do
    it "displays the time unit as plural when it's more than one" do
      struct = OpenStruct.new(qty: 2.0, unit: 'month')
      allow_any_instance_of(OccurrenceCalculator).to receive(:timeframe).and_return(struct)

      expect(helper.occurrence_timeframe(occurrences)).to include('2.0 months')
    end

    it 'displays the time unit as singular appropriate' do
      struct = OpenStruct.new(qty: 1, unit: 'day')
      allow_any_instance_of(OccurrenceCalculator).to receive(:timeframe).and_return(struct)

      expect(helper.occurrence_timeframe(occurrences)).to eq('1 day')
    end
  end

  describe 'formatted_first_occurrence_datetime' do
    it 'formats the datetime given' do
      datetime = '2021-08-01'.to_datetime
      allow_any_instance_of(OccurrenceCalculator).to receive(:first_datetime).and_return(datetime)

      expect(helper.formatted_first_occurrence_datetime(occurrences)).to eq('Sun 08/01/21 at 12:00AM')
    end
  end

  describe 'formatted_last_occurrence_datetime' do
    it 'formats the datetime given' do
      datetime = '2021-08-01'.to_datetime
      allow_any_instance_of(OccurrenceCalculator).to receive(:last_datetime).and_return(datetime)

      expect(helper.formatted_last_occurrence_datetime(occurrences)).to eq('Sun 08/01/21 at 12:00AM')
    end
  end
end
