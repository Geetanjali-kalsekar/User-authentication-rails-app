class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user
      # Generate a token and send it via email (simulated here)
      user.update(reset_token: SecureRandom.urlsafe_base64, reset_sent_at: Time.current)
      redirect_to login_path, notice: 'Password reset instructions sent to your email.'
    else
      flash.now[:alert] = 'Email not found'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find_by(reset_token: params[:id])
    redirect_to new_password_reset_path, alert: 'Invalid or expired token' unless @user
  end

  def update
    @user = User.find_by(reset_token: params[:id])
    if @user&.update(user_params)
      @user.update(reset_token: nil, reset_sent_at: nil)
      redirect_to login_path, notice: 'Password updated successfully'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end