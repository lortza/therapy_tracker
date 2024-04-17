# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LogsHelper, type: :helper do
  describe 'format_datetime' do
    let(:current_datetime) { 'Sat, 23 Mar 2019 14:15:00 -0400'.to_datetime }

    it 'should format time' do
      expect(helper.format_datetime(current_datetime)).to eq('Sat 03/23/19 at 02:15PM')
    end
  end

  describe 'format_time_today_at' do
    let(:current_datetime) { 'Mon, 01 Apr 2024 08:15:00 -0400'.to_datetime }

    it 'should format time' do
      expect(helper.format_time_today_at(current_datetime)).to eq('Today at 08:15 AM')
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
