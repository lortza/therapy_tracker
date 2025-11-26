# frozen_string_literal: true

require "rails_helper"

RSpec.describe OccurrenceCalculator, type: :model do
  let(:calculator) { described_class.new(occurrences) }
  let(:occurrences) { [] }
  let(:user) { create(:user) }
  let(:body_part) { create(:body_part, user: user) }
  let(:pain) { create(:pain, user: user) }
  let(:today) { "01/08/2021".to_datetime }

  describe "avg_pain_level" do
    let(:pain) { create(:pain) }
    let(:occurrences) { pain.logs }

    it "returns an average pain_level of several logs" do
      create(:pain_log, pain: pain, pain_level: 10)
      create(:pain_log, pain: pain, pain_level: 2)
      create(:pain_log, pain: pain, pain_level: 7)

      expect(calculator.avg_pain_level).to eq(6)
    end

    it "returns an average pain_level of a single log" do
      create(:pain_log, pain: pain, pain_level: 2)

      expect(calculator.avg_pain_level).to eq(2)
    end

    context "with no occurrences" do
      let(:occurrences) { [] }

      it "returns 0" do
        expect(calculator.avg_pain_level).to eq(0)
      end
    end
  end

  describe "frequency" do
    context "when there are no occurrences" do
      let(:occurrences) { [] }

      it 'returns "never"' do
        expect(calculator.frequency).to eq("never")
      end
    end

    context "when it only happened once" do
      let(:pain_log1) { create(:pain_log, body_part: body_part, pain: pain, occurred_at: today - 1.month) }
      let(:occurrences) { [pain_log1] }

      it 'returns "once"' do
        expect(calculator.frequency).to eq("once")
      end
    end

    context "when the several occurrences per month" do
      let(:pain_log1) { create(:pain_log, body_part: body_part, pain: pain, occurred_at: "2021-05-01") }
      let(:pain_log2) { create(:pain_log, body_part: body_part, pain: pain, occurred_at: "2021-05-23") }
      let(:occurrences) { [pain_log1, pain_log2] }

      it "reports several occurrences within that unit" do
        expect(calculator.frequency).to eq("1.6 per week")
      end
    end

    context "when several months between occurrences" do
      let(:pain_log1) { create(:pain_log, body_part: body_part, pain: pain, occurred_at: "2021-05-14") }
      let(:pain_log2) { create(:pain_log, body_part: body_part, pain: pain, occurred_at: "2021-08-22") }
      let(:pain_log3) { create(:pain_log, body_part: body_part, pain: pain, occurred_at: "2021-09-02") }
      let(:occurrences) { [pain_log1, pain_log2, pain_log3] }

      it "spreads the occurrences out over several units" do
        expect(calculator.frequency).to eq("1.2 per month")
      end
    end
  end

  describe "timeframe" do
    let(:pain_log1) { create(:pain_log, body_part: body_part, pain: pain, occurred_at: today - 1.month) }
    let(:pain_log2) { create(:pain_log, body_part: body_part, pain: pain, occurred_at: today - 3.months) }
    let(:pain_log3) { create(:pain_log, body_part: body_part, pain: pain, occurred_at: today - 1.day) }
    let(:pain_log4) { create(:pain_log, body_part: body_part, pain: pain, occurred_at: today - 3.days) }
    let(:pain_log5) { create(:pain_log, body_part: body_part, pain: pain, occurred_at: today - 2.weeks) }
    let(:pain_log6) { create(:pain_log, body_part: body_part, pain: pain, occurred_at: today - 2.years) }
    let(:occurrences) { [pain_log1, pain_log2] }

    context "with no occurrences" do
      let(:occurrences) { [] }

      it "returns a default timeframe" do
        expect(calculator.timeframe.qty).to eq(1.0)
        expect(calculator.timeframe.unit).to eq("day")
      end
    end

    it "returns the timeframe between the first and last occurrences" do
      expect(calculator.timeframe.qty).to eq(2.0)
      expect(calculator.timeframe.unit).to eq("month")
    end

    it "does not include timeframes for logs outside of the set" do
      create(:pain_log, body_part: body_part, pain: pain, occurred_at: today - 1.year)
      expect(calculator.timeframe.qty).to_not eq(11.1)
    end

    context "days" do
      let(:occurrences) { [pain_log3, pain_log4] }
      it "returns a unit of days" do
        expect(calculator.timeframe.unit).to eq("day")
      end
    end

    context "weeks" do
      let(:occurrences) { [pain_log3, pain_log5] }
      it "returns a unit of weeks" do
        expect(calculator.timeframe.unit).to eq("week")
      end
    end

    context "months" do
      let(:occurrences) { [pain_log3, pain_log2] }
      it "returns a unit of months" do
        expect(calculator.timeframe.unit).to eq("month")
      end
    end

    context "years" do
      let(:occurrences) { [pain_log5, pain_log6] }
      it "returns a unit of years" do
        expect(calculator.timeframe.unit).to eq("year")
      end
    end
  end

  describe "first_datetime" do
    let(:pain_log1) { create(:pain_log, body_part: body_part, pain: pain, occurred_at: today - 1.month) }
    let(:pain_log2) { create(:pain_log, body_part: body_part, pain: pain, occurred_at: today - 2.months) }
    let(:occurrences) { [pain_log1, pain_log2] }

    it "returns the log with the oldest occurred_at" do
      expect(calculator.first_datetime.to_date).to_not eq(pain_log1.occurred_at.to_date)
      expect(calculator.first_datetime.to_date).to eq(pain_log2.occurred_at.to_date)
    end

    it "does not include records outside of the body_part set" do
      log = create(:pain_log, body_part: body_part, pain: pain, occurred_at: today - 4.months)
      expect(calculator.first_datetime.to_date).to_not eq(log.occurred_at.to_date)
    end
  end

  describe "last_datetime" do
    let(:pain_log1) { create(:pain_log, body_part: body_part, pain: pain, occurred_at: today - 1.month) }
    let(:pain_log2) { create(:pain_log, body_part: body_part, pain: pain, occurred_at: today - 2.months) }
    let(:occurrences) { [pain_log1, pain_log2] }

    it "returns the log with the most recent occurred_at" do
      expect(calculator.last_datetime.to_date).to eq(pain_log1.occurred_at.to_date)
      expect(calculator.last_datetime.to_date).to_not eq(pain_log2.occurred_at.to_date)
    end

    it "does not include records outside of the body_part set" do
      log = create(:pain_log, body_part: body_part, pain: pain, occurred_at: today - 1.day)
      expect(calculator.last_datetime.to_date).to_not eq(log.occurred_at.to_date)
    end
  end
end
