class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(login: params[:login])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to session[:forwarding_url] || root_path
    else
      flash.now[:alert] = 'Please insert correct login and password!'
      render :new
    end
  end

  def destroy
    reset_session
    render :new
  end
end
