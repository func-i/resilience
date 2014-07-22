require 'dumb_delegator'

class BaseDecorator < DumbDelegator
  attr_reader :decorated_object, :view_context

  def initialize decorated_object, view_context
    @decorated_object = super decorated_object
    @view_context = view_context
  end

  def decorated?
    true
  end

  def is_a? klass
    klass == decorated_object.class
  end

  private

  def h
    view_context
  end

end
