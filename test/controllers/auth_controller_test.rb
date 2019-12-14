require 'test_helper'

class AuthControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  test "#index" do
    get user_session_path
    res = JSON.parse(response.body)

    assert_equal(@user.id, res["id"])
    assert_equal(@user.name, res["name"])
    assert_equal(@user.email, res["email"])
    assert_equal(@user.image, res["image"])
  end
end
