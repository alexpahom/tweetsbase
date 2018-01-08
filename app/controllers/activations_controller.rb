class ActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      redirect_to(user, notice: 'Activated!')
    else
      redirect_to(root_path, alert: 'Invalid activation link')
    end
  end
end
