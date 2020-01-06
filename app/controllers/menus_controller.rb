class MenusController < ApplicationController
  def new
    @types = Type.all
  end

  def create
    user = current_user
    params[:types].delete_if {|id| id.blank?}.each do |type_id|
      type = Type.find(type_id)
      begin 
        user.menus.create(type_id: type_id)
        user.muscle_parts.create(part: type.part)
      rescue
        flash[:danger] = "既にメニューに追加済みの種目があります。"
        redirect_to create_menu_path and return
      end
    end
    redirect_to user_path(user)
    flash[:success] = "メニューを作成しました！"
  end
end
