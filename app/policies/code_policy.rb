class CodePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
        .where(organization_id: @user.organization_id)
    end
  end
end
