require 'test_helper'

class CreateMenuTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:valid_user)
    log_in_as(@user)
  end

  test "正しく種目をメニューに追加することができる" do
    get new_menu_path
    assert_response :success
    assert_difference ['@user.menus.count', '@user.muscle_parts.count'], 3 do
      post menus_path, params: {
        types: {"1" => "1", "2" => "2", "3" => "3", "4" => ""}
      }
    end
    assert_redirected_to user_path(@user)
  end

  test "ユーザーと種目の組み合わせは一意である" do
    # ユーザーのメニューの種目の数は３個
    post menus_path, params: {
      types: ["1", "2", "3"]
    }
    # 新たに３つ追加しようと思っても反映されない
    assert_no_difference ['@user.menus.count', '@user.muscle_parts.count'] do
      post menus_path, params: {
        types: ["1", "2", "3"]
      }
    end
  end
end
