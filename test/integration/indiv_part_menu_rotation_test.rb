require 'test_helper'

class IndivPartMenuRotationTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:user_with_two_split_menu)
    log_in_as(@user)
  end

  test "二分割メニューのローテンションを適切に行える" do
    get new_indiv_part_menu_path
    # 1日目のローテ
    assert_equal 1, @user.training_rotation + 1
    # トレーニングローテを1日進める操作
    post indiv_part_menu_index_path
    assert_redirected_to new_indiv_part_menu_path
    follow_redirect!
    assert_equal 1, @user.reload.training_rotation

    # 2日目のローテ
    assert_equal 2, @user.training_rotation + 1
    # トレーニングローテを1日進める操作。一周して0になる
    post indiv_part_menu_index_path
    assert_equal 0, @user.reload.training_rotation
    assert_redirected_to new_indiv_part_menu_path
    follow_redirect!

    # 3日目のローテではなく、一周して1日目のローテ
    assert_equal 1, @user.training_rotation + 1
  end

  test "三分割メニューのローテンションを適切に行える" do
    @user.update_attributes(times_a_week: 3)
    get new_indiv_part_menu_path
    # 1日目のローテ
    assert_equal 1, @user.training_rotation + 1
    # トレーニングローテを1日進める操作
    post indiv_part_menu_index_path
    assert_redirected_to new_indiv_part_menu_path
    follow_redirect!
    assert_equal 1, @user.reload.training_rotation

    # 2日目のローテ
    assert_equal 2, @user.training_rotation + 1
    # トレーニングローテを1日進める操作。一周して0になる
    post indiv_part_menu_index_path
    assert_equal 2, @user.reload.training_rotation
    assert_redirected_to new_indiv_part_menu_path
    follow_redirect!

    # 3日目のローテ
    assert_equal 3, @user.training_rotation + 1
    # トレーニングローテを1日進める操作。一周して0になる
    post indiv_part_menu_index_path
    assert_equal 0, @user.reload.training_rotation
    assert_redirected_to new_indiv_part_menu_path
    follow_redirect!

    # 4日目のローテではなく、一周して1日目のローテ
    assert_equal 1, @user.training_rotation + 1
  end
end