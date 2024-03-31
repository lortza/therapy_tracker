# frozen_string_literal: true

class PainLogDecorator < ApplicationDecorator
  delegate_all

  def icon_name
    'recent_patient'
  end

  def display_name
    'Pain'
  end

  def css_name
    'pain'
  end
end
