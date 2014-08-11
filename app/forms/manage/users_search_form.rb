module Manage
  class UsersSearchForm < BaseSearchForm
    attr_reader :partial_path

    def initialize filtered_fields, field_values, partial_path = nil
      @partial_path = partial_path
      super filtered_fields, (field_values || {})
    end

    def to_partial_path
      return partial_path if partial_path

      'manage/users/search_form'
    end
  end
end
