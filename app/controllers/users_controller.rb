class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/sign_up'
      flash[:success_register] = ['Successfully Created Account']
    else
      flash[:error_register] = [@user.errors.full_messages.join(' and ')]
      redirect_to '/sign_up'
    end
  end
  def new
    @user = User.new
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
