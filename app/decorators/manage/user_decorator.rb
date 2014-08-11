require 'dumb_delegator'

module Manage
  class UserDecorator < BaseDecorator
    attr_reader :user, :view_context

    def initialize user, view_context
      @user = user
      super user, view_context
    end

    def created_at
      super.to_formatted_s(:long)
    end

    def photo
      if super
        h.image_tag user.thumb(:small).url
      else
        # TODO : show default avatar
        nil
      end
    end

    def roles
      super.pluck(:name).
        map(&:humanize).
        join(', ')
    end
  end
end
