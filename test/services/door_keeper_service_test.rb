require 'test_helper'

class DoorKeeperServiceTest < ActiveSupport::TestCase
  test ".open creates an AccessLog if code opens door" do
    org = FactoryBot.create(:organization)
    door = FactoryBot.create(:door, organization: org)
    code = FactoryBot.create(:code, :anytime, organization: org, doors: [door])

    log = DoorKeeperService.open(door: door, value: code.value)

    assert_equal 1, AccessLog.count
    assert_equal true, log.success
    assert_nil log.denied_reason
    assert_equal door.id, log.door_id
    assert_equal code.id, log.code_id
  end

  test ".open creates an AccessLog if bad value supplied" do
    org = FactoryBot.create(:organization)
    door = FactoryBot.create(:door, organization: org)

    log = DoorKeeperService.open(door: door, value: "1234")

    assert_equal 1, AccessLog.count
    assert_equal false, log.success
    assert_equal DoorKeeperService::CODE_UNKNOWN, log.denied_reason
    assert_equal door.id, log.door_id
    assert_nil log.code_id
  end

  test ".open creates an AccessLog if code disabled" do
    org = FactoryBot.create(:organization)
    door = FactoryBot.create(:door, organization: org)
    code = FactoryBot.create(:code, :disabled, organization: org, doors: [door])

    log = DoorKeeperService.open(door: door, value: code.value)

    assert_equal 1, AccessLog.count
    assert_equal false, log.success
    assert_equal DoorKeeperService::CODE_DISABLED, log.denied_reason
    assert_equal door.id, log.door_id
    assert_equal code.id, log.code_id
  end

  test ".open creates an AccessLog if code not associated with door" do
    org = FactoryBot.create(:organization)
    door = FactoryBot.create(:door, organization: org)
    code = FactoryBot.create(:code, :anytime, organization: org)

    log = DoorKeeperService.open(door: door, value: code.value)

    assert_equal 1, AccessLog.count
    assert_equal false, log.success
    assert_equal DoorKeeperService::CODE_NOT_AUTHORIZED, log.denied_reason
    assert_equal door.id, log.door_id
    assert_equal code.id, log.code_id
  end

  test ".open creates an AccessLog if outside of code's allowed time" do
    org = FactoryBot.create(:organization)
    door = FactoryBot.create(:door, organization: org)
    code = FactoryBot.create(:code, organization: org, doors: [door])
    CodeService.new(code).set_time!(from: "9AM", to: "10AM")

    Time.stub :now, '8:59AM'.in_time_zone(door.timezone) do
      log = DoorKeeperService.open(door: door, value: code.value)
      assert_equal 1, AccessLog.count
      assert_equal false, log.success
      assert_equal DoorKeeperService::CODE_OUTSIDE_HOURS, log.denied_reason
      assert_equal door.id, log.door_id
      assert_equal code.id, log.code_id
    end
  end
end
