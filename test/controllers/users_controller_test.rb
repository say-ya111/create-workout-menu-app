require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:valid_user)
    log_in_as(@user)
  end

  test "should get show" do
    get user_path(@user)
    assert_response :success
  end

  # ローテーションの数値がそのままだと新たなの部位別トレーニングが途中からになる
  test "週あたりトレーニング回数更新に合わせてローテーションをリセットする" do
    skip
    assert_not @user.training_rotation == 0
    # トレーニング回数を変更
    patch user_path(@user), params: {
      user: {
        times_a_week: 2
      }
    }, xhr: true
    assert @user.training_rotation == 0
  end
end
