class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_out_path_for(_resource_or_scope)
    splash_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name role email password])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name role email password current_password])
  end

  def authenticate_user!
    return if devise_controller? || (params[:controller] == 'splash' && params[:action] == 'index')

    redirect_to splash_path unless user_signed_in?
  end
end
