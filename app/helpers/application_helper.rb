module ApplicationHelper
  def full_title(title)
    base = "Ruby on Rails Tutorial Sample App"
    if title.empty?
      base
    else
      "#{base} | #{title}"
    end
  end
end
