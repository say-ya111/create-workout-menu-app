class MenusController < ApplicationController
  def new
    @types = Type.all
  end

  def create
    user = current_user
    type_ids = []
    #  例:params[:types] => {"1" => "1", "2" => "2", "3" => "", "4" => "5" => ""}
    params[:types].each{ |k, v| type_ids.push(v) unless v.blank? } # 空文字列を排除して配列に格納
    user.add_type_to_menu(type_ids)
    redirect_to user_path(user)
    flash[:success] = "メニューを作成しました！"
  end
end
