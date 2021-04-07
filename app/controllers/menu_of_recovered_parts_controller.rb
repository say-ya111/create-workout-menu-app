class MenuOfRecoveredPartsController < ApplicationController
  def show
    user = current_user
    @menu_items = user.menu_of_recovered_parts
  end

  def create
    user = current_user
    user.recovered_parts.each do |p|
      p.update_attribute(:last_date, Date.today)
    end
    redirect_to menu_of_recovered_parts_path
    flash.now[:info] = "超回復が完了している部位のみのメニューです！"
  end
end
