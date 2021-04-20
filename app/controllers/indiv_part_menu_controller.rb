class IndivPartMenuController < ApplicationController
  protect_from_forgery except: :new

  def new
    @user = current_user
    @split_menu = current_user.split_menu
    @day = current_user.training_rotation + 1
  end

  def create
    current_user.rotate_rotation
    redirect_to new_indiv_part_menu_path
  end
end
