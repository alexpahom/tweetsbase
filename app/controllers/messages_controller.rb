class MessagesController < ApplicationController
  before_filter :fetch_user

  def fetch_user
    @user = User.find(params[:user_id])
  end

  def index
    @messages = @user.messages.all
  end

  def show
    @message = @user.messages.find(params[:id])
  end

end
