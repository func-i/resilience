class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:error] = t "pundit.#{policy_name}.#{exception.query}",
      default: t('pundit.default')

    redirect_to(request.referrer || root_path)
  end
end
