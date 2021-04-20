require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "example@mail.com", times_a_week: 2, training_rotation: 0, password: "password", password_confirmation: "password")
    @user_with_two_split_menu = users(:user_with_two_split_menu)
    @user_with_two_split_menu.add_type_to_menu([1,2,4,5,9])
    @user.add_type_to_menu(Type.all.pluck(:id))
  end

  test "週あたりトレーニング回数は2~7以内で選択可能" do
    assert_not @user.update_attributes(times_a_week: 1)
    assert_not @user.update_attributes(times_a_week: 8)
  end

  test "二分割メニューを適切に生成" do
    training_rotation = @user_with_two_split_menu.training_rotation
    assert training_rotation == 0
    # ２分割の場合、1回目は上半身メニュー。つまり下半身部位の種目がないことを確認する。
    assert @user_with_two_split_menu.split_menu.preload(:part).any?{|menu_item| !Part.lower_parts.include?(menu_item.part.name)}
    @user_with_two_split_menu.rotate_rotation
    # 2回目は下半身メニュー。上半身部位の種目がないことを確認する。
    assert @user_with_two_split_menu.split_menu.preload(:part).any?{|menu_item| !Part.upper_parts.include?(menu_item.part.name)}
  end

  test "三分割メニューを適切に生成" do
    @user.update_attributes(times_a_week: 3)
    training_rotation = @user.training_rotation
    assert training_rotation == 0
    # 3分割の場合、1回目はpushメニュー。押す部位以外が含まれていないことを確認する
    assert (@user.split_menu.preload(:part).map{|menu_item| menu_item.part.name}.uniq - Part.push_parts).blank?
    @user.rotate_rotation
    # 2回目はpullメニュー。引く部位以外が含まれていないことを確認する。
    assert (@user.split_menu.preload(:part).map{|menu_item| menu_item.part.name}.uniq - Part.pull_parts).blank?
    @user.rotate_rotation
    # 3回目はlegメニュー。脚の部位以外が含まれていないことを確認する。
    assert (@user.split_menu.preload(:part).map{|menu_item| menu_item.part.name}.uniq - Part.lower_parts).blank?
  end

  test "五分割メニューを適切に生成" do
    @user.update_attributes(times_a_week: 5)
    training_rotation = @user.training_rotation
    assert training_rotation == 0
    # 5分割の場合、1回目はbackメニュー。背中部位以外が含まれていないことを確認する
    assert (@user.split_menu.preload(:part).map{|menu_item| menu_item.part.name}.uniq - Part.back_parts).blank?
    @user.rotate_rotation
    # 2回目はchestメニュー。胸の部位以外が含まれていないことを確認する。
    assert (@user.split_menu.preload(:part).map{|menu_item| menu_item.part.name}.uniq - Part.chest_parts).blank?
    @user.rotate_rotation
    # 3回目はlegメニュー。脚の部位以外が含まれていないことを確認する。
    assert (@user.split_menu.preload(:part).map{|menu_item| menu_item.part.name}.uniq - Part.lower_parts).blank?
    @user.rotate_rotation
    # 4回目はshoulerメニュー。肩の部位以外が含まれていないことを確認する。
    assert (@user.split_menu.preload(:part).map{|menu_item| menu_item.part.name}.uniq - Part.shoulder_parts).blank?
    @user.rotate_rotation
    # 5回目はarmメニュー。腕の部位以外が含まれていないことを確認する。
    assert (@user.split_menu.preload(:part).map{|menu_item| menu_item.part.name}.uniq - Part.arm_parts).blank?
  end

  test "七分割メニューを適切に生成" do
    @user.update_attributes(times_a_week: 7, focused_part_id: 1)
    training_rotation = @user.training_rotation
    assert training_rotation == 0
    # 7分割の場合、1回目はarmメニュー。腕す部位以外が含まれていないことを確認する
    assert (@user.split_menu.preload(:part).map{|menu_item| menu_item.part.name}.uniq - Part.arm_parts).blank?
    @user.rotate_rotation
    # 2回目はbackメニュー。背中部位以外が含まれていないことを確認する。
    assert (@user.split_menu.preload(:part).map{|menu_item| menu_item.part.name}.uniq - Part.back_parts).blank?
    @user.rotate_rotation
    # 3回目はchestメニュー。胸の部位以外が含まれていないことを確認する。
    assert (@user.split_menu.preload(:part).map{|menu_item| menu_item.part.name}.uniq - Part.chest_parts).blank?
    @user.rotate_rotation
    # 4回目はlegメニュー。脚の部位以外が含まれていないことを確認する。
    assert (@user.split_menu.preload(:part).map{|menu_item| menu_item.part.name}.uniq - Part.lower_parts).blank?
    @user.rotate_rotation
    # 5回目はshoulderメニュー。肩の部位以外が含まれていないことを確認する。
    assert (@user.split_menu.preload(:part).map{|menu_item| menu_item.part.name}.uniq - Part.shoulder_parts).blank?
    @user.rotate_rotation
    # 6回目はarmメニュー。腕の部位以外が含まれていないことを確認する。
    assert (@user.split_menu.preload(:part).map{|menu_item| menu_item.part.name}.uniq - Part.arm_parts).blank?
    @user.rotate_rotation
    # 7回目は重点部位のメニュー。重点部位(このケースでは大胸筋)以外が含まれていないことを確認する。
    assert (@user.split_menu.preload(:part).map{|menu_item| menu_item.part.name}.uniq - Part.chest_parts).blank?
  end

  test "週４回トレーニングするユーザーを内部的に週３回トレーニングすると見なす" do
    @user.update_attributes(times_a_week: 4)
    assert_equal 3, @user.times_a_week
    user = User.create(email: "test2021@mail.com", times_a_week: 4, password: "password", password_confirmation: "password")
    assert_equal 3, user.times_a_week
  end
end
