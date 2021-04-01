class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :menus, dependent: :destroy
  has_many :menu_items, through: :menus, source: :type
  has_many :muscle_parts, dependent: :destroy

  validates :times_a_week, numericality: {only_integer: true, less_than_or_equal_to: 7, greater_than_or_equal_to: 2}


  # そのユーザーの超回復済みメニュー
  def menu_of_recovered_parts
    menu = []
    # ユーザーの持つ各種目の部位が回復済み部位であるかを判定した後、menuに加える
    self.menu_items.to_a.each do |item|
      if self.recovered_parts_ids.include?(item.part_id)
        menu << item
      end
    end
    return menu
  end

  # 種目をメニューに追加する
  def add_type_to_menu(*type_ids)
    # 配列状のパラメータが引数だと配列の配列になるため
    type_ids.flatten!
    type_ids.each do |type_id|
      menu_data = self.menus.find_or_initialize_by(type_id: type_id)
      menu_data.save
      user_part_data = self.muscle_parts.find_or_initialize_by(part_id: Type.find(type_id).part_id)
      user_part_data.save
    end
  end

  # 回復済みの部位のidを返す
  def recovered_parts_ids
    part_ids = self.muscle_parts.to_a.delete_if{|mp| !mp.is_recovered(Date.today)}.pluck(:part_id)
  end

  # 回復している部位
  def recovered_parts
    self.muscle_parts.to_a.delete_if{|mp| !mp.is_recovered(Date.today)}
  end

  # 部位別メニュー。週何回トレーニングするかによって分ける
  def split_menu
    case self.times_a_week
    when 2
      self.upper_lower_split_menu
    end
  end

  # 上半身部位の種目
  def types_of_upper_parts
    self.menu_items.eager_load(:part).where(parts: {name: Part.upper_parts})
  end

  # 下半身部位の種目
  def types_of_lower_parts
    self.menu_items.eager_load(:part).where(parts: {name: Part.lower_parts})
  end

  # 上半身と下半身に分けたメニュー
  def upper_lower_split_menu
    if self.training_rotation == 0
      self.types_of_upper_parts
    else
      self.types_of_lower_parts
    end
  end

  def upper_menu
    self.muscle_parts.preload(:part)
  end
end
