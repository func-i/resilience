require 'dumb_delegator'
class BaseCollectionDecorator < DumbDelegator
  attr_reader :collection, :view_context

  def initialize collection, view_context
    @collection = super collection
    @view_context = view_context
  end

  def is_a? klass
    super klass
  end

  # delegate Kaminari collection methods
  def current_page
    super
  end

  def total_pages
    super
  end

  def limit_value
    super
  end

  def total_count
    super
  end
end
