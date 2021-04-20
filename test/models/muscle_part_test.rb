require 'test_helper'

class MusclePartTest < ActiveSupport::TestCase

  def setup
    @user = users(:valid_user)
  end

  test "validates user_id, part_id presence" do
    nonuser_id_mp = MusclePart.new(part_id: Part.first.id)
    assert_not nonuser_id_mp.save
    nonpart_mp = @user.muscle_parts.new(part_id: " ")
    assert_not nonpart_mp.save
  end

  test "user_idとpart_idが複合ユニークである" do
    @user.add_type_to_menu([1, 2, 3]) # 種目の部位 -> 胸, 脚, 背筋(fixtureを参照)
    assert_equal @user.muscle_parts.count, 3
    assert_equal @user.menus.count, 3
    
    @user.add_type_to_menu([6, 7, 11]) # 種目の部位 -> 胸, 背筋, 二頭筋,
    # 新しく増えた部位は二頭筋だけなのでmuscle_partsも一つしか増えない
    assert_equal @user.muscle_parts.count, 4
    # 種目はそのまま増える
    assert_equal @user.menus.count, 6
  end
end
