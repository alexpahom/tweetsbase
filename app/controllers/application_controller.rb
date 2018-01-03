class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception
  before_action :require_user

  def require_user
    redirect_to login_path, alert: 'Log in to proceed' unless current_user
  end
end
