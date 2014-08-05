class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  private

  attr_reader :user_roles

  def user_roles
    @user_roles = user.roles.pluck(:name)
  end

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

