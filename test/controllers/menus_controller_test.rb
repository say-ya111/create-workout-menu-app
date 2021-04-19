require 'test_helper'

class MenusControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:valid_user)
    log_in_as(@user)
  end

  test "should get new" do
    get create_menu_path
    assert_response :success
  end
end
