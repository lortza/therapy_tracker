# frozen_string_literal: true

class SlitLogDecorator < ApplicationDecorator
  delegate_all

  def display_name
    "SLIT Dose"
  end

  def icon_name
    "colorize"
  end

  def css_name
    "slit"
  end
end
