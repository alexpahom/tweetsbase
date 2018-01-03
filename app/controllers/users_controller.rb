class UsersController < ApplicationController
  before_action :fetch_user, only: %i(show edit update destroy)
  skip_before_action :require_user, only: %i(new create)

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
      redirect_to(users_path, notice: 'Everything worked out!')
    else
      redirect_to(new_user_path,
                  alert: 'Username / Email should be unique. All the fields should be populated')
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
      format.html { redirect_to(users_path, notice: 'Deleted.') }
      format.js
    end
  end

  def fetch_user
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(%i(username first_name last_name email phone))
  end
end
