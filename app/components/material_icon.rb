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

  # TODO size classes aren't being acknowledged by the icon. This feature is not working.
  # I'm overriding via inline styles.
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
    "#{base_classes} #{@filled} #{@provided_classes}"
  end

  def computed_inline_styles
    "font-size: #{@size};"
  end

  def base_classes
    "align-middle"
  end
end
