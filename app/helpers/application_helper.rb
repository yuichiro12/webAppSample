module ApplicationHelper
  def full_title(title = "")
    title.empty? ? "YOURSKILL" : title + " - YOURSKILL"
  end
end
