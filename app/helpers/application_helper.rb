module ApplicationHelper
  def full_title(page_title='')
    base_title = "menu"
    if !page_title.blank?
      page_title + " | " + base_title
    else
      "menu"
    end
  end
end
