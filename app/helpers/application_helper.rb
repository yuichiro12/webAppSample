module ApplicationHelper
  def full_title(title = "")
    title.empty? ? "WebAppSample" : title + " - WebAppSample"
  end
end
