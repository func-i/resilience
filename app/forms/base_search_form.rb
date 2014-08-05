class BaseSearchForm
  include ActiveModel::Conversion
  include ActiveModel::Model

  attr_accessor :filtered_fields

  # Initialize new search form which can be rendered into views
  # @param filtered_fields [Array]
  # @param field_values [Array]
  # @param partial_path [String] partial path for search form
  # @returns [BaseSearchForm]
  def initialize filtered_fields, field_values
    @filtered_fields = filtered_fields
    @field_values = field_values || {}
    build_accessors
  end

  # Set ActiveModel persisted to false
  def persisted?
    false
  end

  # Set ActiveModel to_key to empty array
  def to_key
    []
  end

  # Partail path for the search form model
  # @returns [String]
  def to_partial_path
    raise NotImplementedError
  end

  private

  # Build dynamic accessor from field_values
  # they are used in form templates
  def build_accessors
    @filtered_fields.each do |method_name|
      (class << self; self; end).class_eval do
        define_method method_name do
          @field_values[method_name] || ''
        end
      end
    end
  end
end
