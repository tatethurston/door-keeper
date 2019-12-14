require 'test_helper'

class TwilioControllerTest < ActionDispatch::IntegrationTest
  test "#index" do
    get twilio_index_path

    assert_includes(response.body, access_twilio_index_path)
  end

  test "#access unlocks door when DoorKeeperService success" do
    digits = '1234'
    test_door = FactoryBot.create(:door, phone_number: digits)
    mock = MiniTest::Mock.new
    mock.expect(:call, FactoryBot.build(:access_log, success: true)) do |door:, value:|
      assert_equal(value, digits)
      assert_equal(door, test_door)
    end

    DoorKeeperService.stub(:open, mock) do
      post access_twilio_index_path, params: {
        Digits: digits,
        To: test_door.phone_number
      }

      assert_includes(response.body, '<Play digits="w9"/>')
    end

    mock.verify
  end

  test "#access does not unlock door when DoorKeeperService denied" do
    digits = '1234'
    test_door = FactoryBot.create(:door, phone_number: digits)
    mock = MiniTest::Mock.new
    mock.expect(:call, FactoryBot.build(:access_log, success: false, denied_reason: DoorKeeperService::CODE_UNKNOWN)) do |door:, value:|
      assert_equal(value, digits)
      assert_equal(door, test_door)
    end

    DoorKeeperService.stub(:open, mock) do
      post access_twilio_index_path, params: {
        Digits: digits,
        To: test_door.phone_number
      }

      refute_includes(response.body, '<Play digits="w9"/>')
    end

    mock.verify
  end

  test "#access when unknown code" do
    digits = '1234'
    test_door = FactoryBot.create(:door, phone_number: digits)
    mock = MiniTest::Mock.new
    mock.expect(:call, FactoryBot.build(:access_log, success: false, denied_reason: DoorKeeperService::CODE_UNKNOWN)) do |door:, value:|
      assert_equal(value, digits)
      assert_equal(door, test_door)
    end

    DoorKeeperService.stub(:open, mock) do
      post access_twilio_index_path, params: {
        Digits: digits,
        To: test_door.phone_number
      }

      assert_includes(response.body, "<Say>Sorry, I don't recognize that code. Please try again.</Say>")
    end

    mock.verify
  end

  test "#access when unauthorized code" do
    digits = '1234'
    test_door = FactoryBot.create(:door, phone_number: digits)
    mock = MiniTest::Mock.new
    mock.expect(:call, FactoryBot.build(:access_log, success: false, denied_reason: DoorKeeperService::CODE_OUTSIDE_HOURS)) do |door:, value:|
      assert_equal(value, digits)
      assert_equal(door, test_door)
    end

    DoorKeeperService.stub(:open, mock) do
      post access_twilio_index_path, params: {
        Digits: digits,
        To: test_door.phone_number
      }

      assert_includes(response.body, "<Say>That code is not authorized for this door at this time.</Say>")
    end

    mock.verify
  end
end
