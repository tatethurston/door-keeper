require 'test_helper'

class OmniauthControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    OmniAuth.config.test_mode = true
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
  end

  def teardown
    OmniAuth.config.test_mode = false
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end

  test "#google_oauth2 creates new users" do
    OmniAuth.config.add_mock(:google_oauth2, info:
                             FactoryBot.build(:user).as_json)

    assert_equal(0, User.count)

    get user_google_oauth2_omniauth_authorize_path
    follow_redirect!

    assert_equal(1, User.count)
  end

  test "#google_oauth2 signs in existing user" do
    user = FactoryBot.create(:user)
    OmniAuth.config.add_mock(:google_oauth2,  info: {
                               name: user.name,
                               email: user.email,
                               image: user.image
                             })

    assert_equal(1, User.count)

    get user_google_oauth2_omniauth_authorize_path
    follow_redirect!

    assert_equal(1, User.count)
  end
end
