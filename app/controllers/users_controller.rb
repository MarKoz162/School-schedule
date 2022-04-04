class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_path, notice: "User was successfully destroyed"
    else
      redirect_to users_path, alert: " Dont working "
    end
  end

  def ban
    @user = User.find(params[:id])
    if @user.access_locked?
      @user.unlock_access!
      redirect_to users_path, notice: "User was unbanned "
    else
      @user.lock_access!
      redirect_to users_path, notice: "User was banned "
    end
    
    
  end

end