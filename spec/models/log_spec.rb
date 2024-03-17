# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Log, type: :module do
  describe 'self.all' do
    it 'returns a list of logs for a specific user' do
      user = create(:user)
      pain_log = create(:pain_log, user_id: user.id)

      expect(Log.all(user)).to match_array([pain_log])
    end

    it 'contains all 3 types of logs' do
      user = create(:user)
      pain_log = create(:pain_log, user_id: user.id)
      exercise_log = create(:exercise_log, user_id: user.id)
      pt_session_log = create(:pt_session_log, user_id: user.id)

      expect(Log.all(user)).to include(pain_log)
      expect(Log.all(user)).to include(exercise_log)
      expect(Log.all(user)).to include(pt_session_log)
    end

    it 'is ordered by occurred_at in descending order' do
      user = create(:user)
      first_log = create(:exercise_log,
                         user_id: user.id,
                         occurred_at: '2019-01-01 1:00:00')

      last_log = create(:exercise_log,
                        user_id: user.id,
                        occurred_at: '2019-01-01 2:00:00')

      expect(Log.all(user).first).to eq(last_log)
      expect(Log.all(user).last).to eq(first_log)
    end
  end

  describe 'for_past_n_days' do
    # This is tested within the individual _log specs
  end

  describe 'for_body_part' do
    # This is tested within the individual _log specs
  end
end
