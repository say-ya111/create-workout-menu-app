class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :menus, dependent: :destroy
  has_many :menu_items, through: :menus, source: :type

  has_many :muscle_parts, dependent: :destroy

  def menu_of_recovered_parts
    menu = []
    self.menu_items.to_a.each do |item|
      if self.recovered_parts_names.include?(item.part)
        menu << item
      end
    end
    return menu
  end

  def add_type_to_menu(*type_ids)
    # 配列状のパラメータが引数だと配列の配列になるため
    type_ids.flatten!
    type_ids.each do |type_id|
      menu_data = self.menus.find_or_initialize_by(type_id: type_id)
      menu_data.save
      user_part_data = self.muscle_parts.find_or_initialize_by(part: Type.find(type_id).part)
      user_part_data.save
    end
  end

  def recovered_parts_names
    self.muscle_parts.to_a.delete_if{|mp| !mp.is_recovered(Date.today)}.pluck(:part)
  end

  def recovered_parts
    self.muscle_parts.to_a.delete_if{|mp| !mp.is_recovered(Date.today)}
  end
end
