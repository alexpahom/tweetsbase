class MessagesController < ApplicationController
  include MessagesHelper
  before_action :fetch_user, except: :recent
  before_action :fetch_message, only: %i(show edit update destroy)
  skip_before_action :require_permission, only: %i(index show recent)

  def fetch_user
    @user = User.find(params[:user_id])
  end

  def fetch_message
    @message = @user.messages.find(params[:id])
  end

  def index
    @messages = @user.messages.all.order(updated_at: :desc)
  end

  def show; end

  def edit; end

  def new
    @message = Message.new
  end

  def create
    @message = @user.messages.create(message_params)
    if @message.save
      redirect_to(user_messages_path, notice: 'Post created.')
    else
      redirect_to(new_user_message_path, alert: @message.errors.full_messages.to_sentence)
    end
  end

  def update
    if @message.update_attributes(message_params)
      redirect_to(user_message_path, notice: 'Post updated.')
    else
      redirect_to(edit_user_message_path, alert: @message.errors.full_messages.to_sentence)
    end
  end

  # TODO: pagination
  def recent
    @messages = Message.all.order(updated_at: :desc).limit(10)
  end

  def destroy
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(user_messages_path(@user), notice: 'Deleted.') }
      format.js
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
