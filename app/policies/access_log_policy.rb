class AccessLogPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
        .joins(:door)
        .where(doors: { organization_id: @user.organization_id })
    end
  end
end
