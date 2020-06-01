class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
   @users = User.all
   @users = policy_scope(User)
   authorize User
  end 
  
  def destroy
    @user.destroy
    redirect_to users_path
  end 

  private

  def set_user
   @user = User.find(params[:id])
 end

  def user_params
   params.require(:user).permit(:name, :email, :user_avatar, :password)
 end
end
