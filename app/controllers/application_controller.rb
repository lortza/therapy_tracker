# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :set_sentry_context
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def require_admin
    redirect_to root_path, alert: 'Must be Admin to access this area' unless current_user_admin?
  end

  def current_user_admin?
    current_user&.admin?
  end
  helper_method :current_user_admin?

  def authorized_user?(object)
    object.user_id == current_user.id
  end

  def authorization_alert
    "Whoops! You're not authorized to view that page."
  end

  # New Configs: https://docs.sentry.io/platforms/ruby/migration/
  def set_sentry_context
    Sentry.set_user(id: session[:current_user_id]) # or anything else in session
    Sentry.set_extras(params: params.to_unsafe_h, url: request.url)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name admin])
  end
end
