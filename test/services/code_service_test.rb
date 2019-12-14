require "test_helper"

class CodeServiceTest < ActiveSupport::TestCase
  test "#set_time! sets time" do
    code = FactoryBot.create(:code)

    CodeService.new(code).set_time!(from: "9AM", to: "10AM")
    assert_equal "9AM-10AM", code.allowed_time
  end

  test "#enable! enables code" do
    code = FactoryBot.create(:code, disabled_at: Time.now)

    c = CodeService.new(code)
    c.enable!
    assert_equal true, c.enabled?
  end

  test "#disable! disables code" do
    code = FactoryBot.create(:code, allowed_time: nil)

    time = "9AM".in_time_zone("UTC")
    c = CodeService.new(code)
    Time.stub :now, time do
      c.disable!
    end

    assert_equal time, code.disabled_at
    assert_equal false, c.enabled?
  end

  test "#enabled? returns true when disabled_at set" do
    code = FactoryBot.create(:code, disabled_at: Time.now)
    c = CodeService.new(code)

    assert_equal false, c.enabled?
  end

  test "#enabled? returns false when disabled_at nil" do
    code = FactoryBot.create(:code, disabled_at: nil)
    c = CodeService.new(code)

    assert_equal true, c.enabled?
  end

  test "#can_open? true if associated with door" do
    door = FactoryBot.create(:door)
    code = FactoryBot.create(:code, doors: [door])
    c = CodeService.new(code)

    assert_equal true, c.can_open?(door)
  end

  test "#can_open? false if not associated with door" do
    door = FactoryBot.create(:door)
    code = FactoryBot.create(:code)
    c = CodeService.new(code)

    assert_equal false, c.can_open?(door)
  end

  test "#allowed_time? true if within time" do
    code = FactoryBot.create(:code, allowed_time: "9AM-10AM")
    c = CodeService.new(code)

    time = "9AM".in_time_zone("UTC")
    assert_equal true, c.allowed_time?(time)
  end

  test "#allowed_time? true if allowed_time nil" do
    code = FactoryBot.create(:code, allowed_time: nil)
    c = CodeService.new(code)

    assert_equal true, c.allowed_time?(nil)
  end

  test "#allowed_time? false if not within time" do
    code = FactoryBot.create(:code, allowed_time: "9AM-10AM")
    c = CodeService.new(code)

    time = "10:01AM".in_time_zone("UTC")
    assert_equal false, c.allowed_time?(time)
  end
end
