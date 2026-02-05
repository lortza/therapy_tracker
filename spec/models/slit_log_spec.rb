# frozen_string_literal: true

## == Schema Information
#
# Table name: slit_logs
#
#  id                 :bigint           not null, primary key
#  dose_skipped       :boolean
#  doses_remaining    :integer
#  occurred_at        :datetime
#  started_new_bottle :boolean          default(FALSE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :bigint           not null
#
# Indexes
#
#  index_slit_logs_on_occurred_at  (occurred_at)
#  index_slit_logs_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe SlitLog, type: :model do
  context "associations" do
    it { should belong_to(:user) }
  end

  context "validations" do
    it { should validate_presence_of(:occurred_at) }
  end

  describe "before_save actions" do
    describe "private: set_doses_remaining" do
      before do
        user = create(:user)
        create(:slit_log, user: user, occurred_at: DateTime.current - 2.days, doses_remaining: previous_balance)
      end

      context "when the new log contains a value for doses_remaining" do
        let(:slit_log) { build(:slit_log, doses_remaining: 15) }
        let(:previous_balance) { 30 }

        it "sets uses the existing doses_remaining value" do
          slit_log.send(:set_doses_remaining)
          expect(slit_log.doses_remaining).to eq(15)
        end
      end

      context "when starting a new bottle" do
        let(:slit_log) { build(:slit_log, started_new_bottle: true) }
        let(:previous_balance) { nil }

        it "sets the doses_remaining to the default value" do
          slit_log.send(:set_doses_remaining)
          expect(slit_log.doses_remaining).to eq(SlitLog::MAX_BOTTLE_DOSES)
        end
      end

      context "when a previous log's doses_remaining is not available" do
        let(:slit_log) { build(:slit_log) }
        let(:previous_balance) { nil }

        it "sets the doses_remaining to nil" do
          slit_log.send(:set_doses_remaining)
          expect(slit_log.doses_remaining).to be(nil)
        end
      end

      context "when a previous log's doses_remaining is available" do
        let(:slit_log) { build(:slit_log) }
        let(:previous_balance) { 1 }

        it "calls calculate_doses_remaining" do
          expect(slit_log).to receive(:calculate_doses_remaining)
          slit_log.send(:set_doses_remaining)
        end
      end
    end
  end

  describe "private: #calculate_doses_remaining" do
    context "when the current log is a skipped dose" do
      it "uses the previous log's value" do
        previous_value = 5
        expect(SlitLog.new(dose_skipped: true).send(:calculate_doses_remaining, previous_value)).to eq(previous_value)
      end
    end

    context "when the previous log's value is greater than zero" do
      it "returns the previous log's value minus 1" do
        expect(SlitLog.new.send(:calculate_doses_remaining, 5)).to eq(4)
      end
    end

    context "when the previous log's value is zero" do
      it "returns 0" do
        expect(SlitLog.new.send(:calculate_doses_remaining, 0)).to eq(0)
      end
    end

    context "when the previous log's value is less than zero" do
      it "returns 0" do
        expect(SlitLog.new.send(:calculate_doses_remaining, -1)).to eq(0)
      end
    end
  end
end
