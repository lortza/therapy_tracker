# frozen_string_literal: true

class MaterialIconComponent
  # https://fonts.google.com/icons
  include ActionView::Helpers::TagHelper

  def initialize(icon:, title: nil, size: :inherit, filled: false, classes: nil, weight: :normal)
    @icon = icon.to_sym
    @title = title
    @size = size
    @filled = filled ? 'icon-filled' : 'icon-outlined'
    @provided_classes = classes
    @weight = weight
  end

  def render
    content_tag(
      :span, @icon,
      style: computed_inline_styles,
      class: symbol_classes,
      title: @title.presence || @icon
    )
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
    'align-middle'
  end
end
