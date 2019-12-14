require 'test_helper'

class CodesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @code = FactoryBot.create(:code)
    user = FactoryBot.create(:user, organization: @code.organization)
    sign_in user
  end

  test "#index" do
    get codes_path
    res = JSON.parse(response.body)

    assert_equal(1, res.length)
    assert_equal(@code.id, res[0]["id"])
  end

  test "#show" do
    get code_path(@code.id)
    res = JSON.parse(response.body)

    assert_equal(@code.id, res["id"])
  end
end
