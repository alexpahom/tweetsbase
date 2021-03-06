class UsersController < ApplicationController
  include UsersHelper
  before_action :fetch_user, only: %i(show edit update destroy)
  before_action :push_if_logged, only: %i(new create)
  skip_before_action :require_login, only: %i(new create)
  skip_before_action :require_permission, only: %i(index show new create)

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show; end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      redirect_to(root_path, notice: 'Check your inbox on order to activate account')
    else
      redirect_to(root_path,
                  alert: @user.errors.full_messages.to_sentence)
    end
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to(user_path, notice: 'Successfully saved.')
    else
      redirect_to(edit_user_path, alert: 'Cannot be saved')
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Deleted.' }
      format.js
    end
  end

  def fetch_user
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(%i(username first_name last_name email phone password))
  end
end
