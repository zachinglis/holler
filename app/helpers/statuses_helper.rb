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
end
