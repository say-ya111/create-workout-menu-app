require 'test_helper'

class PartsRecoveringTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:valid_user)
    log_in_as(@user)
  end

  test "ユーザーの部位が回復し、超回復済みメニューが作られる" do
    # 筋トレ種目をメニューに追加
    post menus_path, params: {
        types: {"1" => "1", "2" => "2", "3" => "3"}
      }
    # ユーザーの部位が種目の数だけ作られる
    assert_equal @user.muscle_parts.count, 3
    # 追加直後は部位は回復している
    assert_equal @user.recovered_parts.count, 3
    # 超回復済みメニューに種目が３つ入る
    assert_equal @user.menu_of_recovered_parts.count, 3
    # トレーニング完了。部位は非回復状態になる
    patch menu_of_recovered_parts_path
    assert_equal @user.reload.recovered_parts.count, 0
    assert_equal @user.menu_of_recovered_parts.count, 0
    # 全ての部位が回復するまで時間を進める
    travel @user.muscle_parts.pluck(:recovery_span).max.days
    assert_equal @user.reload.recovered_parts.count, 3
    assert_equal @user.reload.menu_of_recovered_parts.count, 3
  end
end
