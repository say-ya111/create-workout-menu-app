class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]
  
  def show
    @menu_items = @user.menu_items
  end

  def update
    @user.update_attributes(user_params.merge({training_rotation: 0}))
  end

  private
  
  def user_params
    params.require(:user).permit(
      :times_a_week
    )
  end

  def set_user
    if !params[:id].nil?
      @user = User.find(params[:id])
    end
  end
end
