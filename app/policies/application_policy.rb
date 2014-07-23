class ApplicationPolicy < Struct.new(:user, :record)
  attr_reader :user_roles

  def user_roles
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user_roles ||= user.roles.pluck(:name)
  end
end

