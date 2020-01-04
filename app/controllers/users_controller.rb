class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @menu_items = @user.menu_items
  end
end
