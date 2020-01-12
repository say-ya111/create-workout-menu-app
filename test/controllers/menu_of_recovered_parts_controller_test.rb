require 'test_helper'

class MenuOfRecoveredPartsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get menu_of_recovered_parts_show_url
    assert_response :success
  end

  test "should get create" do
    get menu_of_recovered_parts_create_url
    assert_response :success
  end

end
