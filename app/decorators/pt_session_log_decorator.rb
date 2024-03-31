# frozen_string_literal: true

class PtSessionLogDecorator < ApplicationDecorator
  delegate_all

  def display_name
    'PT Session'
  end

  def icon_name
    'physical_therapy'
  end

  def css_name
    'therapy'
  end
end
