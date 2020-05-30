class MenusController < ApplicationController
  def new
    @types = Type.all
  end

  def create
    user = current_user
     # params[:types]先頭に空文字列が入るためdelete_if
    user.add_type_to_menu(params[:types].delete_if {|id| id.blank?})
    redirect_to user_path(user)
    flash[:success] = "メニューを作成しました！"
  end
end
