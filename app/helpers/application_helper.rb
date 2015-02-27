module ApplicationHelper
  def fix_url(url)
    url.starts_with?('http://') ? url : "http://#{url}"
  end

  def fix_time(time)
    time.strftime("%l:%M%P %b. %e, %Y")
  end
end
