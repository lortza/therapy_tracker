# frozen_string_literal: true

class MaterialIcon
  # https://fonts.google.com/icons
  include ActionView::Helpers::TagHelper

  def initialize(icon:, title: nil, size: :inherit, filled: false, classes: nil, weight: :lighter)
    @icon = icon.to_sym
    @title = title
    @size = size
    @filled = filled ? 'icon-filled' : 'icon-outlined'
    @provided_classes = classes
    @weight = weight
  end

  def render
    case @icon
    when :exercise then exercise;
    when :pain then recent_patient;
    when :logo then clinical_notes;
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
      style: computed_inline_styles,
      class: symbol_classes,
      title: @title.presence || 'SLIT Therapy')
  end

  def exercise
    content_tag(:span, 'exercise',
      style: computed_inline_styles,
      class: symbol_classes,
      title: @title.presence || 'Exercise')
  end

  def clinical_notes
    content_tag(:span, 'clinical_notes',
      style: computed_inline_styles,
      class: symbol_classes,
      title: @title.presence || 'Therapy Tracker')
  end

  def physical_therapy
    content_tag(:span, 'physical_therapy',
      style: computed_inline_styles,
      class: symbol_classes,
      title: @title.presence || 'Physical Therapy')
  end

  def recent_patient
    content_tag(:span, 'recent_patient',
      style: computed_inline_styles,
      class: symbol_classes,
      title: @title.presence || 'Pain')
  end

  def search
    content_tag(:span, 'search',
      style: computed_inline_styles,
      class: symbol_classes,
      title: @title.presence || "Search")
  end

  private

  def size_style
    case @size
    when :xsmall then '.75rem'
    when :small then '1rem'
    when :medium then '1.5rem'
    when :large then '2rem'
    when :xlarge then '2.5rem'
    when :xxlarge then '3rem'
    when :inherit then 'inherit'
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
    "#{base_classes} #{@filled} #{@provided_classes}"
  end

  def computed_inline_styles
    "font-size: #{size_style}; font-weight: #{@weight};"
  end

  def base_classes
    "align-middle"
  end
end
