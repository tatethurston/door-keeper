class DoorKeeperService
  CODE_UNKNOWN = "code_unknown"
  CODE_DISABLED = "code_disabled"
  CODE_NOT_AUTHORIZED = "code_not_authorized"
  CODE_OUTSIDE_HOURS = "code_outside_hours"

  class << self
    def open(door:, value:)
      code = find_code(value: value, door: door)
      if code.nil?
        return AccessLog.create!(
          door: door,
          success: false,
          denied_reason: CODE_UNKNOWN,
        )
      end

      errors = validate_can_open?(door: door, code: code)
      if errors.empty?
        AccessLog.create!(door: door, code: code, success: true)
      else
        AccessLog.create!(
          door: door,
          code: code,
          success: false,
          denied_reason: errors.first
        )
      end
    end

    private

      def validate_can_open?(door:, code:)
        errors = []
        c = CodeService.new(code)

        if !c.enabled?
          errors << CODE_DISABLED
        end

        if !c.can_open?(door)
          errors << CODE_NOT_AUTHORIZED
        end

        time_at_door = Time.now.in_time_zone(door.timezone)
        if !c.allowed_time?(time_at_door)
          errors << CODE_OUTSIDE_HOURS
        end

        errors
      end

      def find_code(value:, door:)
        Code
          .includes(:doors)
          .find_by(value: value, organization: door.organization)
      end
  end
end
