ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def log_in_as(user) # with devise gem
    if integration_test?
      include Devise::Test::IntegrationHelpers
    else
      sign_in(user, scope: :user)
    end
    login_as(user, :scope => user)
  end

  def current_user
    User.find_by(email:session.to_hash.values[2]["email"])
  end

  private

    # 統合テスト内でtrue
    def integration_test?
      defined?(post_via_redirect)
    end
end
