class WeatherItem < ApplicationRecord

  belongs_to :city

  scope :tomorrow_weather_items, -> { where('start_at between ? and ?', Time.new.tomorrow.change(hour: 00, min: 00, sec: 00), (Time.new+2.days).change(hour: 00, min: 00, sec: 00)) }

  def import
    city = City.find_by!(is_current_location: true)
    weather_data = fetch_weather_data(city.open_weather_identifier)
    weather_data['list'].each do |entry|
      start_time = DateTime.strptime(entry['dt'].to_s,'%s')
      end_time = start_time + 3.hours
      type = entry['weather'][0]['main'].downcase
      weather_item = WeatherItem.find_or_initialize_by(city_id: city.id, start_at: start_time)
      weather_item.update_attributes(end_at: end_time, weather_type: type)
      weather_item.save!
    end
  end

  def fetch_weather_data(open_weather_city_id)
    url = URI("http://api.openweathermap.org/data/2.5/forecast?id=#{open_weather_city_id}&APPID=#{Settings.open_weather_api.api_key}&mode=json")
    http = Net::HTTP.new(url.host, url.port)
    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    body = JSON.parse(response.read_body)
  end

  def delete_needless_data
    WeatherItem.where('end_at < ?', Time.now).destroy_all
  end
end
