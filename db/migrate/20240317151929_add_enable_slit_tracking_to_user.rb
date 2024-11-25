# frozen_string_literal: true

class AddEnableSlitTrackingToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :enable_slit_tracking, :boolean, default: false
  end
end
