class AccessLogPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
        .joins(:door)
        .where(door: { organization_id: @user.organization_id })
    end
  end
end
