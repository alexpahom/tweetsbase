module UsersHelper
  def push_if_logged
    redirect_back(fallback_location: users_path, alert: 'User has been created already') if logged?
  end

  def my_user?(user)
    current_user.id == user.id
  end
end
