require 'will_paginate/view_helpers/action_view'

class TailwindLinkRenderer < WillPaginate::ActionView::LinkRenderer
  def container_attributes
    { class: 'flex justify-center space-x-2' }
  end

  def page_number(page)
    if page == current_page
      tag(:span, page, class: 'px-3 py-1 bg-blue-500 text-white rounded')
    else
      link(page, page, class: 'px-3 py-1 border border-gray-300 rounded hover:bg-gray-100')
    end
  end

  def gap
    tag(:span, '&#8230;'.html_safe, class: 'px-3 py-1')
  end

  def previous_or_next_page(page, text, classname)
    if page
      link(text, page, class: 'px-3 py-1 border border-gray-300 rounded hover:bg-gray-100')
    else
      tag(:span, text, class: 'px-3 py-1 bg-gray-200 text-gray-500 rounded')
    end
  end
end 