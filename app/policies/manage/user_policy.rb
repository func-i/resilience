class Manage::UserPolicy < ManagePolicy
  def update_params params
    params.require(:user).
      permit(role_ids: [])
  end
end
