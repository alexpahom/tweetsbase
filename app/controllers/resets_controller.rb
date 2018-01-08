class ResetsController < ApplicationController
  skip_before_action :require_login
  before_action :fetch_user, only: %i(edit update)
  before_action :valid_user, only: %i(edit update)

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

  private

  def fetch_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    redirect_to(root_path) unless @user&.activated? && @user.authenticated?(:reset, params[:id])
  end
end
