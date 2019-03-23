class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def require_admin
    unless current_user_admin?
      redirect_to root_path, alert: 'Must be Admin to access this area'
    end
  end

  def current_user_admin?
    current_user&.admin?
  end
  helper_method :current_user_admin?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :admin])
  end
end
