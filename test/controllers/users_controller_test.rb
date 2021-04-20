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
end
