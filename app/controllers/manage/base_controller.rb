class Manage::BaseController < ApplicationController
  include Manage::Sortable

  before_action :authenticate_user!, :authorize_user!

  private

  def authorize_user!
    raise Pundit::NotAuthorizedError \
      unless authorize :manage, :can_manage?
  end
end
