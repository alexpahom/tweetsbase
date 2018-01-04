class ApplicationController < ActionController::Base
  include SessionsHelper
  include ApplicationHelper
  protect_from_forgery with: :exception
  before_action :require_login
  before_action :require_permission

  def require_permission
    redirect_back(fallback_location: root_path, alert: 'I bet you\'re not allowed to') if
        (controller_name == 'Messages' && current_user.id != params[:user_id].to_i) ||
            (controller_name == 'Users' && current_user.id != params[:id].to_i)
  end
end
