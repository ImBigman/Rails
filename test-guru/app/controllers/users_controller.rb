class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user = current_user
      session[:user_id] = User.last.id
      redirect_to tests_path, notice: 'Congratulations! Your account was created!'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :login, :email, :password, :password_confirmation)
  end
end
