class CodeService
  TIME_SEPERATOR = '-'

  def initialize(code)
    @code = code
  end

  def set_time!(from:, to:)
    @code.update!(allowed_time: from + TIME_SEPERATOR + to)
  end

  def enable!
    @code.update!(disabled_at: nil)
  end

  def disable!
    @code.update!(disabled_at: Time.now)
  end

  def enabled?
    @code.disabled_at.nil?
  end

  def can_open?(door)
    @code.doors.include?(door)
  end

  def allowed_time?(time)
    return true if @code.allowed_time.nil?

    tz = ActiveSupport::TimeZone[time.utc_offset / 3600]
    from, to = @code.allowed_time.split(TIME_SEPERATOR).map do |t|
      t.in_time_zone(tz)
    end

    time.between?(from, to)
  end
end
