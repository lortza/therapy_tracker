module LogsHelper
  def format_time(log)
    # log.datetime_occurred.strftime("%a %m/%d/%y at %I:%M %p in %Z")
    log.datetime_occurred.strftime("%a %m/%d/%y at %I:%M%p")
  end

  def last_log(kollection, attr)
    current_user.send(kollection)[-2].send(attr) if current_user.send(kollection)[-2]
  end
end
