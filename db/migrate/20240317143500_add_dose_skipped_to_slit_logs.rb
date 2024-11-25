# frozen_string_literal: true

class AddDoseSkippedToSlitLogs < ActiveRecord::Migration[7.0]
  def change
    add_column :slit_logs, :dose_skipped, :boolean, default: false
  end
end
