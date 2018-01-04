module UsersHelper
  def push_if_logged
    redirect_back(messages_path, alert: 'User has been created already') if logged?
  end

  def require_permission
    unless current_user.id == params[:id].to_i
      redirect_back(fallback_location: root_path, alert: 'I bet you\'re not allowed to')
    end
  end
end
