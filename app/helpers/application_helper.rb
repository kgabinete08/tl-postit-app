module ApplicationHelper
  def fix_url(url)
    url.starts_with?('http://') ? url : "http://#{url}"
  end

  def display_time(time)
    time.try(:strftime, "%l:%M%P %b. %e, %Y")
  end
end
