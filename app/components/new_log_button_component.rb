# frozen_string_literal: true

class NewLogButtonComponent
  def initialize(log_klass:, text: nil, path: nil, method: :get)
    @log_klass = log_klass
    @text = text
    @path = path
    @method = method
  end

  def render
    ActionController::Base.helpers.link_to(button_text, computed_path, method: @method, class: computed_classes)
  end

  private

  # rubocop:disable Rails/OutputSafety
  # Disabling is safe because this content ALWAYS comes from internal sources
  def button_text
    MaterialIconComponent.new(
      icon: decorated_log.icon_name,
      size: :large
    ).render + "<br>+#{computed_text}".html_safe
  end
  # rubocop:enable Rails/OutputSafety

  def decorated_log
    @decorated_log ||= @log_klass.new.decorate
  end

  def computed_path
    @path || "#{@log_klass.to_s.underscore}s/new"
  end

  def computed_text
    @text || decorated_log.display_name
  end

  def computed_classes
    "add-log-button #{decorated_log.css_name}-button"
  end
end
