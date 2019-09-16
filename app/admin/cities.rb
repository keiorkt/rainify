ActiveAdmin.register City do
   permit_params :name, :is_current_location, :open_weather_identifier
end
