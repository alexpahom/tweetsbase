class ResetsController < ApplicationController
  skip_before_action :require_login
  before_action :fetch_user, only: %i(edit update)
  before_action :valid_user, only: %i(edit update)
  before_action :check_expiration, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by(email: params[:reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      redirect_to(root_path, notice: 'Email sent with password reset instructions')
    else
      redirect_to(new_reset_path, alert: 'Email was not found')
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      redirect_to(root_path, alert: 'can\'t be empty')
    elsif @user.update_attributes(user_params)
      log_in @user
      redirect_to(@user, notice: 'Password is changed')
    else
      redirect_to(edit_reset_path(@user.reset_token, email: @user.email), alert: 'Something went wrong')
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def fetch_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    redirect_to(root_path) unless @user&.activated? && @user.authenticated?(:reset, params[:id])
  end

  def check_expiration
    redirect_to(new_reset_url, alert: 'Expired') if @user.password_reset_expired?
  end
end
