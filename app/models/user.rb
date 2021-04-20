class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :menus, dependent: :destroy
  has_many :menu_items, through: :menus, source: :type
  has_many :muscle_parts, dependent: :destroy

  validates :times_a_week, numericality: {only_integer: true, less_than_or_equal_to: 7, greater_than_or_equal_to: 2}

  before_create :set_focused_part
  after_save :regard_four_times_as_three_times
  belongs_to :focused_part, class_name: "Part", foreign_key: "focused_part_id", optional: true


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
    case times_a_week
    when 2
      upper_lower_split_menu
    when 3, 4, 6
      three_split_menu
    when 5
      five_split_menu
    when 7
      seven_split_menu
    end
  end

  # 二分割メニューをローテーションに合わせて返す
  def upper_lower_split_menu
    if training_rotation == 0
      upper_menu
    else
      lower_menu
    end
  end

  # 三分割メニューをローテーションに合わせて返す
  def three_split_menu
    case training_rotation
    when 0
      push_menu
    when 1 
      pull_menu
    when 2
      lower_menu
    when 3
      push_menu
    when 4
      pull_menu
    when 5
      lower_menu
    end
  end

  # 五分割メニューをローテーションに合わせて返す
  def five_split_menu
    case training_rotation
    when 0
      back_menu
    when 1
      chest_menu
    when 2
      lower_menu
    when 3
      shoulder_menu
    when 4
      arm_menu
    end
  end

  # 七分割メニューをローテーションに合わせて返す
  def seven_split_menu
    case training_rotation
    when 0
      arm_menu
    when 1
      back_menu
    when 2
      chest_menu
    when 3
      lower_menu
    when 4
      shoulder_menu
    when 5
      arm_menu
    when 6
      focused_part_menu(focused_part.name)
    end
  end

  # 押す種目
  def push_menu
    menu_items.eager_load(:part).where(parts: {name: Part.push_parts})
  end

  # 引く種目
  def pull_menu
    menu_items.eager_load(:part).where(parts: {name: Part.pull_parts})
  end

  # 上半身部位の種目
  def upper_menu
    menu_items.eager_load(:part).where(parts: {name: Part.upper_parts})
  end

  # 下半身部位の種目
  def lower_menu
    menu_items.eager_load(:part).where(parts: {name: Part.lower_parts})
  end

  # 背中種目
  def back_menu
    menu_items.eager_load(:part).where(parts: {name: Part.back_parts})
  end

  # 胸種目
  def chest_menu
    menu_items.eager_load(:part).where(parts: {name: Part.chest_parts})
  end

  # 肩種目
  def shoulder_menu
    menu_items.eager_load(:part).where(parts: {name: Part.shoulder_parts})
  end

  # 腕種目
  def arm_menu
    menu_items.eager_load(:part).where(parts: {name: Part.arm_parts})
  end

  # ユーザが選択した重点部位の種目
  def focused_part_menu(focused_part)
    menu_items.eager_load(:part).where(parts: {name: focused_part})
  end

  # トレーニングローテーションを回す。週あたりトレーニング回数を超えないように。
  def rotate_rotation
    if (next_training_rotation = training_rotation + 1) >= times_a_week
      self.update_attributes(training_rotation: 0)
    else
      self.update_attributes(training_rotation: next_training_rotation)
    end
  end

  private

    # 週4回も週3回も同じローテーションで分割メニューを組むので更新＆作成のタイミングで3回に書き換えておく。
    def regard_four_times_as_three_times
      self.update_attributes(times_a_week: 3) if self.times_a_week == 4
    end

    # 新規作成時に重点部位を設定。
    def set_focused_part
      self.focused_part_id = Part.first
    end
end
