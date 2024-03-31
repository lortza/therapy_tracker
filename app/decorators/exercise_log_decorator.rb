# frozen_string_literal: true

class ExerciseLogDecorator < ApplicationDecorator
  delegate_all

  def display_name
    'Exercise'
  end

  def icon_name
    'exercise'
  end

  def css_name
    'exercise'
  end
end
