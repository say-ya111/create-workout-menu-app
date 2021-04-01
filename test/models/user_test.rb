require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "mail@mail.com", times_a_week: 2, password: "password", password_confirmation: "password")
  end

  test "週あたりトレーニング回数は2~7以内で選択可能" do
    assert_not @user.update_attributes(times_a_week: 1)
    assert_not @user.update_attributes(times_a_week: 8)
  end
end
