class BatchService
  def do
    Calendar.new.import
    Event.new.import_all
    WeatherItem.new.import
  end

  def calc_should_notify
  end
end