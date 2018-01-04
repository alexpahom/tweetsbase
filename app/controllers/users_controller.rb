class UsersController < ApplicationController
  before_action :fetch_user, only: %i(show edit update destroy)
  skip_before_action :require_login, only: %i(new create)
  skip_before_action :require_permission, only: %i(index show)

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show; end

  def edit; end

  def create
    @user = User.create(user_params)
    if @user.save
      log_in @user
      redirect_to(users_path, notice: 'Everything worked out!')
    else
      redirect_to(new_user_path,
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
