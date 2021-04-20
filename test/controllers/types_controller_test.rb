require 'test_helper'

class TypesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:valid_user)
    @another_valid_user = users(:another_valid_user)
    log_in_as(@user)
  end
  test "should get index" do
    get types_list_path
    assert_response :success
  end

  test 'ユーザーに紐づいた種目を作成' do
    assert_difference ['@user.menus.count', '@user.muscle_parts.count'] do
      post types_path params: {
        type: "テスト種目",
        part: "1"
      }
    assert_equal @user.id, Type.last.user_id
    end
  end

  test '作った種目は他ユーザに影響を及ぼさない' do
  # 注：@userでログイン中
    assert_no_difference ['@another_valid_user.menus.count', '@another_valid_user.muscle_parts.count'] do
      post types_path params: {
        type: "テスト種目",
        part: "1"
      }
    end
  end
end
