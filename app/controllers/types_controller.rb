class TypesController < ApplicationController
  def index
    @types = Type.where(user_id: 0).or(Type.where(user_id: current_user.id))
  end

  def new
    # 部位の選択肢用に全てのPartを取り出す
    @part = Part.all
  end

  def create
    user = current_user
    user.menu_items.create(name: params[:type], part_id: params[:part], user_id: user.id)
    mp = user.muscle_parts.find_or_initialize_by(part_id: params[:part])
    mp.save
    redirect_to types_list_url
  end
end
