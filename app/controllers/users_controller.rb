class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy, :ban]
  before_action :require_admin, only: [:edit, :update, :ban, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    @user.update(user_params)
    if @user.update(user_params)
      redirect_to @user, notice: "User was sucessfully update"
    else
      render :edit    
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_path, notice: "User was successfully destroyed"
    else
      redirect_to users_path, alert: " Dont working "
    end
  end

  def ban
    if @user.access_locked?
      @user.unlock_access!
      redirect_to users_path, notice: "User was unbanned "
    else
      @user.lock_access!
      redirect_to users_path, notice: "User was banned "
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(*User::ROLES)
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorize to perform this action "
    end
  end

end