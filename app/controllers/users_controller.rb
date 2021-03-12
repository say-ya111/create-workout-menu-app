class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @menu_items = @user.menu_items
  end

  def update
    User.find(params[:id]).update_attributes(user_params)
  end

  private
  
  def user_params
    params.require(:user).permit(
      :email,
      :times_a_week
    )
  end
end
