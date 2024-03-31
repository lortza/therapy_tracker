# frozen_string_literal: true

class SlitLog < ApplicationRecord
  belongs_to :user

  validates :occurred_at, presence: true

  DOSE_TO_PLACE_ORDER = 60

  def display_name
    'SLIT Dose'
  end

  def self.icon_name
    'colorize'
  end

  def icon_name
    SlitLog.icon_name
  end

  def css_name
    'slit'
  end
end
