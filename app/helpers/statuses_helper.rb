module StatusesHelper
  def today_tomorow_or_day(time)
    case time.utc.yday
    when Time.now.utc.yday
      "Today"
    when 1.day.ago.yday
      "Yesterday"
    else
      time.strftime("%A")
    end
  end
  
  def user_class(user, current_user)
    "highlight" if user == current_user
  end
  
  def status_time_ago_in_words(time)
    time = time_ago_in_words(time)
    case time
    when "less than a minute"
      "recently"
    else
      time.gsub(/about /,'') + " ago"
    end
  end
end
