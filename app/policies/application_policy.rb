class ApplicationPolicy < Struct.new(:user, :record)
  attr_reader :user_roles

  def user_roles
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user_roles ||= user.roles.pluck(:name)
  end

  private

  def permited_for roles
    roles = roles.join(' ')

    roles_matcher = user_roles.inject('') do |m, item|
      if m.blank?
        m = "#{item}"
      else
        m += "|#{item}"
      end
    end

    !roles.match(Regexp.new(roles_matcher)).nil?
  end
end

