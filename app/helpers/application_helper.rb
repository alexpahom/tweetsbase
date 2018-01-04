module ApplicationHelper
  def alert_class_for(flash_type)
    {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end

  def owner?(text)
    current_user.id == text.user_id
  end

  def admin?
    # current_user.role == 'master'
  end

  def require_permission
    unless current_user.id == params[:user_id]
      redirect_back(fallback_location: root_path, alert: 'I bet you\'re not allowed to')
    end
  end

  def require_login
    redirect_to login_path, alert: 'Log in to proceed' unless current_user
  end
end
