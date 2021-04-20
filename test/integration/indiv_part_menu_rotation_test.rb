require 'test_helper'

class IndivPartMenuRotationTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:user_with_two_split_menu)
    log_in_as(@user)
  end

  test "二分割メニューのローテンションを適切に行える" do
    get new_indiv_part_menu_path
    assert_rotation(@user.times_a_week)
  end

  test "三分割メニューのローテンションを適切に行える" do
    # 週に3,4,6回トレーニングするユーザは三分割メニュー。
    @user.update_attributes(times_a_week: 3)
    get new_indiv_part_menu_path
    assert_rotation(@user.times_a_week)

    @user.update_attributes(times_a_week: 4)
    get new_indiv_part_menu_path
    assert_rotation(@user.times_a_week)

    @user.update_attributes(times_a_week: 6)
    get new_indiv_part_menu_path
    assert_rotation(@user.times_a_week)
  end

  test "五分割メニューのローテンションを適切に行える" do
    @user.update_attributes(times_a_week: 5)
    get new_indiv_part_menu_path
    assert_rotation(@user.times_a_week)
  end

  test "七分割メニューのローテンションを適切に行える" do
    @user.update_attributes(times_a_week: 7)
    get new_indiv_part_menu_path
    assert_rotation(@user.times_a_week)
  end

  private

    def assert_rotation(times_a_week)
      times_a_week.times do |rotation_num|
          # n日目のローテ
        assert_equal rotation_num, @user.training_rotation
        # トレーニングローテを1日進める操作
        post indiv_part_menu_index_path
        assert_redirected_to new_indiv_part_menu_path
        follow_redirect!
        assert_equal (rotation_num + 1) >= @user.times_a_week ? 0 : rotation_num + 1, @user.reload.training_rotation
      end
    end
end