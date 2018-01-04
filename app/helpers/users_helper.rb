module UsersHelper
  def push_if_logged
    redirect_back(fallback_location: users_path, alert: 'User has been created already') if logged?
  end
end
