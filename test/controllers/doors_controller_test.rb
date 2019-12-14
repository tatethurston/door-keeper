require 'test_helper'

class DoorsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    user = FactoryBot.create(:user)
    sign_in user
    @door = FactoryBot.create(:door, organization: user.organization)
  end

  test "#index" do
    get doors_path
    res = JSON.parse(response.body)

    assert_equal(1, res.length)
    assert_equal(@door.id, res[0]["id"])
  end

  test "#show" do
    get door_path(@door.id)
    res = JSON.parse(response.body)

    assert_equal(@door.id, res["id"])
  end
end
