module MessagesHelper
  def owner?(text)
    current_user.id == text.user_id
  end
end
