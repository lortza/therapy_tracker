# frozen_string_literal: true

module SlitLogReport
  RECORD_LIMIT = 90
  DOSE_TO_PLACE_ORDER = 60

  class << self
    def default_start_date
      Date.current - RECORD_LIMIT.days
    end

    def default_end_date
      Date.current
    end

    def place_order_index
      DOSE_TO_PLACE_ORDER
    end
  end
end
