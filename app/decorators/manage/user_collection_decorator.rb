require 'dumb_delegator'

module Manage
  class UserCollectionDecorator < BaseCollectionDecorator
    attr_reader :users, :view_context

    def initialize users, view_context
      @users = users
      super users, view_context
    end

    def each(&block)
      users.each do |user|
        block.call(::Manage::UserDecorator.new user, view_context)
      end
    end
  end
end
