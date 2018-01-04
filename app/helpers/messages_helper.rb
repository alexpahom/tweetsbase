module MessagesHelper
  def require_permission
    unless current_user.id == params[:user_id].to_i
      redirect_back(fallback_location: root_path, alert: 'I bet you\'re not allowed to')
    end
  end
end
