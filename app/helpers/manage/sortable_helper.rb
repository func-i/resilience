module Manage
  module SortableHelper
   def sort_by_link(table, column, title = nil)
      icon_class = nil
      full_column_name = table.empty? ? "#{column.to_s}" : "#{table}.#{column.to_s}"

      css_class = if full_column_name == sort_column
        icon_class = {'asc' => 'fi-arrow-up', 'desc' => 'fi-arrow-down'}[sort_direction]
        "current-#{full_column_name}"
      end

      direction = (full_column_name == sort_column && sort_direction == "asc") ? "desc" : "asc"
      new_params = params.merge({sort: full_column_name, direction: direction})

      link_to new_params, class: "#{css_class} sortable" do
        if icon_class.present?
          "#{content_tag(:i, nil, class: icon_class).html_safe} #{title}"
        else
          title
        end.html_safe
      end
    end
  end
end
