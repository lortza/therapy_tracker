# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LogsHelper, type: :helper do
  describe 'format_datetime' do
    it 'should format time' do
      log = build(:exercise_log)
      expect(helper.format_datetime(log.occurred_at)).to eq('Sat 03/23/19 at 02:08 PM')
    end
  end

  describe 'last_log' do
    it 'should find the second to last log' do
      user = create(:user)
      allow(helper).to receive(:current_user).and_return(user)

      create(:pain_log, user_id: user.id, pain_level: 1)
      create(:pain_log, user_id: user.id, pain_level: 2)
      create(:pain_log, user_id: user.id, pain_level: 3)

      user.reload
      expect(helper.last_log(:pain_logs, :pain_level)).to eq(2)
    end
  end
end
