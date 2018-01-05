module ApplicationHelper
  def alert_class_for(flash_type)
    {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end

  def admin?
    current_user.role == 'master'
  end

  def require_login
    redirect_to login_path, alert: 'Log in to proceed' unless current_user
  end
end
