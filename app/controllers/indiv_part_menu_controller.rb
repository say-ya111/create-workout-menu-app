class IndivPartMenuController < ApplicationController
  protect_from_forgery except: :new

  def new
    user = current_user
    times_a_week = user.times_a_week
    
    # @user_types = user.menu_items
    # # 上半身と下半身に分けるユーザー用
    # if params[:section] == "upper-or-lower"
    #   @type_options = user.types_of_upper_parts if params[:part] == "upper"
    #   @type_options = user.types_of_lower_parts if params[:part] == "lower"
    # end

    # respond_to do |format|
    #   format.js
    #   format.html
    # end
  end

  def create

  end
end
