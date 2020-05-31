require 'test_helper'

class TypesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get types_list_path
    assert_response :success
  end

end
