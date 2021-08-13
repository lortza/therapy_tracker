# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReportsHelper, type: :helper do
  let(:user) { create(:user) }

  describe 'avg_pain_level' do
    let(:pain) { create(:pain) }

    it 'returns an average pain_level of several logs' do
      create(:pain_log, pain: pain, pain_level: 10)
      create(:pain_log, pain: pain, pain_level: 2)
      create(:pain_log, pain: pain, pain_level: 7)

      expect(helper.avg_pain_level(pain.logs)).to eq(6)
    end

    it 'returns an average pain_level of a single log' do
      create(:pain_log, pain: pain, pain_level: 2)

      expect(helper.avg_pain_level(pain.logs)).to eq(2)
    end
  end

  xcontext 'occurrences ordering', freeze_time: true do
    let(:ache) { create(:pain, user: user) }
    let(:neck) { create(:body_part, user: user) }
    let!(:pain_log_today) do
      create(:pain_log, user: user, pain: ache, body_part: neck, datetime_occurred: 5.hours.ago)
    end
    let!(:pain_log_yesterday) do
      create(:pain_log, user: user, pain: ache, body_part: neck, datetime_occurred: 24.hours.ago)
    end

    let(:arse) { create(:body_part) }
    let!(:arse_pain_log_today) do
      create(:pain_log, user: user, pain: ache, body_part: arse, datetime_occurred: 2.hours.ago)
    end
    let!(:arse_pain_log_yesterday) do
      create(:pain_log, user: user, pain: ache, body_part: arse, datetime_occurred: 25.hours.ago)
    end

    let(:neck_report) { Report.new(user: user, timeframe: '', body_part_id: neck.id) }

    let(:neck_occurrences) do
      neck_report.pain_stats_by_body_part.map { |_pain, occurrences| occurrences }.first
    end

    describe 'first_occurrence_datetime' do
      it 'returns the log with the oldest datetime_occurred' do
        expect(helper.first_occurrence_datetime(neck_occurrences)).to eq(pain_log_yesterday.datetime_occurred)
        expect(helper.first_occurrence_datetime(neck_occurrences)).to_not eq(pain_log_today.datetime_occurred)
      end

      it 'does not include records outside of the body_part set' do
        expect(helper.first_occurrence_datetime(neck_occurrences)).to_not eq(arse_pain_log_yesterday.datetime_occurred)
      end
    end

    describe 'last_occurrence_datetime' do
      it 'returns the log with the most recent datetime_occurred' do
        expect(helper.last_occurrence_datetime(neck_occurrences)).to eq(pain_log_today.datetime_occurred)
        expect(helper.last_occurrence_datetime(neck_occurrences)).to_not eq(pain_log_yesterday.datetime_occurred)
      end

      it 'does not include records outside of the body_part set' do
        expect(helper.last_occurrence_datetime(neck_occurrences)).to_not eq(arse_pain_log_today.datetime_occurred)
      end
    end
  end
end
