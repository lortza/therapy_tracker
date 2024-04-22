# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SlitLogSkippedDoseService, type: :service do
  let(:service) { described_class.call }
  describe 'self.call' do
    let(:user) { create(:user) }
    let(:yesterday_string) { '2024-04-01' }
    let(:yesterday_date) { Date.parse(yesterday_string) }
    let(:yesterday_datetime) { 'Mon, 01 Apr 2024 00:00:00.000000000 EDT -04:00' }
    let(:today_date) { Date.parse('2024-04-02') }

    before do
      allow(Date).to receive(:yesterday).and_return(yesterday_date)
      allow(Date).to receive(:today).and_return(today_date)
    end

    context 'when there are multiple users of the app' do
      it 'calculates skips in context to the user' do
        user_who_skipped = create(:user, enable_slit_tracking: true)
        user_who_took_dose = create(:user, enable_slit_tracking: true)
        user_who_took_dose.slit_logs.create!(occurred_at: yesterday_string)

        service
        aggregate_failures do
          expect(user_who_skipped.slit_logs.last.dose_skipped?).to eq(true)
          expect(user_who_took_dose.slit_logs.last.dose_skipped?).to eq(false)
          expect(user_who_skipped.slit_logs.count).to eq(1)
          expect(user_who_took_dose.slit_logs.count).to eq(1)
        end
      end

      it 'creates a skip log for all users who have SLIT tracking enabled and skipped a dose' do
        user_who_skipped = create(:user, enable_slit_tracking: true)
        other_user_who_skipped = create(:user, enable_slit_tracking: true)

        service
        aggregate_failures do
          expect(user_who_skipped.slit_logs.last.dose_skipped?).to eq(true)
          expect(other_user_who_skipped.slit_logs.last.dose_skipped?).to eq(true)
          expect(user_who_skipped.slit_logs.count).to eq(1)
          expect(other_user_who_skipped.slit_logs.count).to eq(1)
        end
      end
    end

    context 'when the user is not on SLIT therapy' do
      let(:user) { create(:user, enable_slit_tracking: false) }

      it 'does not create a skip log' do
        expect { service }.not_to(change { SlitLog.count })
      end
    end

    context 'when a user is on SLIT therapy' do
      let(:user) { create(:user, enable_slit_tracking: true) }

      context 'and has no slit_logs' do
        it 'creates a skip log' do
          expect { service }.to(change { user.slit_logs.count })
        end
      end

      context 'and logged a dose yesterday' do
        it 'does not create a skip log' do
          user.slit_logs.create(occurred_at: yesterday_string)
          expect { service }.not_to(change { user.slit_logs.count })
        end
      end

      context 'and did not log a dose yesterday' do
        before { user }

        it 'creates a log' do
          expect { service }.to change { SlitLog.count }.by(1)
        end

        it "creates a log with yesterday's date" do
          service
          user.slit_logs.reload
          last_log = user.slit_logs.order(occurred_at: :desc).first
          expect(last_log.occurred_at).to eq(yesterday_datetime)
        end

        it "creates a log with yesterday's date and dose_skipped: true" do
          service
          last_log = user.slit_logs.order(occurred_at: :desc).first
          expect(last_log.dose_skipped).to eq(true)
        end
      end

      context "and yesterday's log is for a skipped dose" do
        it 'does not create another skipped dose log for yesterday' do
          user.slit_logs.create!(occurred_at: yesterday_string, dose_skipped: true)
          expect { service }.not_to(change { user.slit_logs.count })
        end
      end
    end
  end
end
