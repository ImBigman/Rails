class ApplicationController < ActionController::Base

  helper_method :current_user,
                :logged_in?,
                :store_location,
                :redirect_back_or
  private

  def authenticate_user!
    unless current_user
      store_location
      redirect_to login_path, congratulation: 'Enter your email and password please!'
    end

    cookies[:login] = current_user&.login
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def logged_in?
    current_user.present?
  end
end
