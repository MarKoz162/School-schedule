class UsersController < ApplicationController
  before_action :find_user, except: [:index]
  before_action :require_admin, except: [:index, :show, :resend_invitation, :edit, :update]
  before_action :require_admin_or_inviter, only: [:resend_invitation]
  before_action :require_admin_or_owner, only: [:edit, :update]
  
  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def resend_confirmation_instructions
    if @user.confirmed? == false && @user.created_by_invite? == false
      @user.resend_confirmation_instructions
      redirect_to users_path, notice: "Confirmations instractions were resend"
    else
      redirect_to users_path, alert: "User already confirmed"
    end
  end

  def resend_invitation
    if @user.created_by_invite? && @user.invitation_accepted? == false && @user.confirmed? == false
      @user.invite!
      redirect_to users_path, notice: "Inovation was resent"
    else
      @user.resend_confirmation_instructions
      redirect_to users_path, alert: "User already confirmed"
    end
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
    if @user == current_user
      redirect_to users_path, notice: "You can't ban yourself "
    else
      if @user.access_locked?
        @user.unlock_access!
        redirect_to users_path, notice: "User was unbanned "
      else
        @user.lock_access!
        redirect_to users_path, notice: "User was banned "
      end
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    list_allowed_params = []
    list_allowed_params += [:name] if current_user == @user
    list_allowed_params += [*User::ROLES] if current_user.admin?
    params.require(:user).permit(list_allowed_params)
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorize to perform this action "
    end
  end

  def require_admin_or_inviter
    find_user
    unless current_user.admin? || @user.invited_by == current_user
      redirect_to root_path, alert: "You are not authorize to perform this action "
    end
  end

  def require_admin_or_owner
    find_user
    unless current_user.admin? || current_user == @user
      redirect_to root_path, alert: "You are not authorize to perform this action "
    end
  end

end