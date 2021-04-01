require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "example@mail.com", times_a_week: 2, password: "password", password_confirmation: "password")    
    @user_with_two_split_menu = users(:user_with_two_split_menu)
    @user_with_two_split_menu.add_type_to_menu([1,2,4,5,9])
  end

  test "週あたりトレーニング回数は2~7以内で選択可能" do
    assert_not @user.update_attributes(times_a_week: 1)
    assert_not @user.update_attributes(times_a_week: 8)
  end

  test "２分割メニューを適切に生成" do
    training_rotation = @user_with_two_split_menu.training_rotation
    assert training_rotation == 0
    # ２分割の場合、1回目は上半身メニュー。つまり下半身部位の種目がないことを確認する。
    assert @user_with_two_split_menu.split_menu.preload(:part).any?{|menu_item| !Part.lower_parts.include?(menu_item.part.name)}
    @user_with_two_split_menu.update_attributes(training_rotation: training_rotation + 1)
    # 2回目は下半身メニュー。上半身部位の種目がないことを確認する。
    assert @user_with_two_split_menu.split_menu.preload(:part).any?{|menu_item| !Part.upper_parts.include?(menu_item.part.name)}
  end

end
