class SessionsController < ApplicationController
  skip_before_action :require_login, only: %i(new create)
  skip_before_action :require_permission

  def new
    redirect_to messages_path if logged?
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user&.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to messages_path, notice: 'Logged in'
    else
      redirect_to root_path, alert: 'Invalid username or password'
    end
  end

  def destroy
    log_out if logged?
    redirect_to root_path, notice: 'Logged out'
  end
end
