class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name login])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name login])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[first_name last_name login])
  end

  def admin_required!
    redirect_to root_path, alert: 'You are not authorized to view this page!' unless current_user.admin?
  end

  def after_sign_in_path_for(resource)
    flash[:notice] = "Hello, #{current_user.first_name}!"
    stored_location_for(resource) ||
      if current_user.admin?
        admin_tests_path
      else
        super
      end
  end
end


