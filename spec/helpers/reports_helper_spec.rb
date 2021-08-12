# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReportsHelper, type: :helper do
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
end
