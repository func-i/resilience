module Manage
  module Sortable
    extend ActiveSupport::Concern

    included do
      helper 'manage/sortable'
      helper_method :sort_column,
        :sort_direction,
        :set_default_sorting,
        :sort_by
    end

    private

    attr_accessor :sort_direction

    def sort_by
      sort = "#{sort_column} #{sort_direction}"
      sort.present? ? sort : nil
    end

    def sort_column
      params[:sort]
    end

    def sort_direction
      @sort_direction ||= params[:direction]
    end

    # Set default sorting column and direction
    def set_default_sorting  table_name, column , direction
      full_column_name = table_name.empty? ? "#{column}" : "#{table_name}.#{column}"
      params[:sort] ||= full_column_name
      params[:direction] ||= direction
      "#{full_column_name} #{direction}"
    end
  end
end
