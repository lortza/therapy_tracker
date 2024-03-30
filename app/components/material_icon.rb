# frozen_string_literal: true

class MaterialIcon
  # https://fonts.google.com/icons
  include ActionView::Helpers::TagHelper

  def initialize(icon:, title: nil, size: :inherit, filled: false, classes: nil)
    @icon = icon.to_sym
    @title = title
    @size = size
    @filled = filled ? 'icon-filled' : 'icon-outlined'
    @provided_classes = classes
  end

  def render
    case @icon
    when :exercise then exercise;
    when :pain then recent_patient;
    when :pt_session then physical_therapy;
    when :slit then colorize;
    when :search then search;
    else
      raise "ERROR: There is no ':#{@icon}' icon. See app/components/material_icon.rb for icon options."
    end
  end

  private

  def colorize
    content_tag(:span, 'colorize',
      class: symbol_classes,
      title: @title.presence || 'SLIT Therapy')
  end

  def exercise
    content_tag(:span, 'exercise',
      class: symbol_classes,
      title: @title.presence || 'Exercise')
  end

  def physical_therapy
    content_tag(:span, 'physical_therapy',
      class: symbol_classes,
      title: @title.presence || 'Physical Therapy')
  end

  def recent_patient
    content_tag(:span, 'recent_patient',
      class: symbol_classes,
      title: @title.presence || 'Pain')
  end

  def search
    content_tag(:span, 'search',
      class: symbol_classes,
      title: @title.presence || "Search")
  end

  private

  def size_class
    case @size
    when :xsmall then 'text-xsmall'
    when :small then 'text-small'
    when :medium then 'text-medium'
    when :large then 'text-large'
    when :xlarge then 'text-xlarge'
    when :xxlarge then 'text-xxlarge'
    when :inherit then 'text-size-inherit'
    else
      raise 'ERROR: Available sizes are :xsmall, :small, :medium, :large, :xlarge, :xxlarge, :inherit'
    end
  end

  def symbol_classes
    "material-symbols-outlined #{computed_classes}"
  end

  def icon_classes
    # icon classes do not support "filled"
    "material-icons-outlined #{computed_classes}"
  end

  def computed_classes
    "#{base_classes} #{size_class} #{@filled} #{@provided_classes}"
  end

  def base_classes
    "align-middle"
  end
end
