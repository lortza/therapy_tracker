# frozen_string_literal: true

class AddEnablePtSessionTrackingToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :enable_pt_session_tracking, :boolean, default: :false
  end
end

