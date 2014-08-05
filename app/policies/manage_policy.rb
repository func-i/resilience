class ManagePolicy < ApplicationPolicy

  def manage?
    permited_for ['administrator']
  end

end
