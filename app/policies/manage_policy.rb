class ManagePolicy < ApplicationPolicy
  MANAGE_ROLES = ['administrator']

  def can_manage?
    user.has_any_role?(*MANAGE_ROLES)
  end
end
