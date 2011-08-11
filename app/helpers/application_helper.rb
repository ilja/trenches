module ApplicationHelper
  require 'rdiscount' 

  # markdown -> html
  def markdown(string)
    return if string.nil?
    markdown = RDiscount.new(string, :filter_html)
    markdown.to_html.html_safe
  end
end
