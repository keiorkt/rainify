ActiveAdmin.register WeatherItem do
  permit_params :city_id, :forecast_for, :precipitation_percentage
end
