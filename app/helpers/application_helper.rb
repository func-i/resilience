module ApplicationHelper

  def page_title title
    content_for :page_title do
      content_tag(:div, class: 'row page-title') do
        content_tag :div, title, class: 'small-12 columns' do
          content_tag :h2, title
        end
      end
    end
  end

end
