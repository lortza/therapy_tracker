# frozen_string_literal: true

# link_to MaterialIconComponent.new(icon: ExerciseLog.new.decorate.icon_name, size: :large).render + '<br>+Exercise'.html_safe, new_exercise_log_path, class: 'add-log-button exercise-button'

class NewLogButtonComponent
  # include ActionView::Helpers::TagHelper

  def initialize(log_klass:, text: nil, path:, method: :get, classes: nil)
    @log_klass = log_klass
    @text = text || decorated_log.display_name
    @path = path
    @method = method
    @classes = classes
  end

  def render
    ActionController::Base.helpers.link_to(button_text, @path, method: @method, class: computed_classes)
  end

  private

  def button_text
    MaterialIconComponent.new(icon: decorated_log.icon_name, size: :large).render + "<br>+#{@text}".html_safe
  end

  def decorated_log
    @decorated_log ||= @log_klass.new.decorate
  end

  def computed_classes
    "add-log-button #{decorated_log.css_name}-button"
  end
end
