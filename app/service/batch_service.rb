class BatchService
  def do
    Calendar.new.import
    Event.new.import_all
    WeatherItem.new.import

    tomorrow_events = Event.tomorrow_events
    if tomorrow_events.present?
      weather = check_weather
      notify(weather, tomorrow_events) if weather.present?
    end
  end

  def check_weather
    prediction = 'fine'
    weathers = WeatherItem.tomorrow_weather_items
    weathers.each do { |weather|
      if (weather.weather_type =~ /rain/).present? || (weather.weather_type =~ /thunderstorm/).present?
        return weather.weather_type
      end
    }
    return nil
  end

  def notify(weather, events)
    text = "Tomorrow is #{weather} \n"
    events.each do |event|
      text += "#{event.summary} from #{event.start_at.strftime("%Y/%m/%d %H:%M")}\n"
    end
    LineMessagingService.broadcast(text)
  end
end
