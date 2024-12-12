class UsersController < ApplicationController
  before_action :require_login, only: [:show]

  def new
    @user = User.new
  end

  def show
  @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, notice: 'User successfully created. Please log in.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :age, :contact, :email, :password, :password_confirmation)
  end

    private

  def require_login
    unless session[:user_id]
      redirect_to login_path, alert: "Please log in to access this page."
    end
  end
end
