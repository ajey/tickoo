class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
  end
  
  def after_sign_in_path_for(resource)
    if current_user.admin?
      admin_path
    else
      tickets_path
    end
  end
end