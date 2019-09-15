require 'test_helper'

class WeatherItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @weather_item = weather_items(:one)
  end

  test "should get index" do
    get weather_items_url
    assert_response :success
  end

  test "should get new" do
    get new_weather_item_url
    assert_response :success
  end

  test "should create weather_item" do
    assert_difference('WeatherItem.count') do
      post weather_items_url, params: { weather_item: { city_id: @weather_item.city_id, forecast_for: @weather_item.forecast_for, precipitation_percentage: @weather_item.precipitation_percentage } }
    end

    assert_redirected_to weather_item_url(WeatherItem.last)
  end

  test "should show weather_item" do
    get weather_item_url(@weather_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_weather_item_url(@weather_item)
    assert_response :success
  end

  test "should update weather_item" do
    patch weather_item_url(@weather_item), params: { weather_item: { city_id: @weather_item.city_id, forecast_for: @weather_item.forecast_for, precipitation_percentage: @weather_item.precipitation_percentage } }
    assert_redirected_to weather_item_url(@weather_item)
  end

  test "should destroy weather_item" do
    assert_difference('WeatherItem.count', -1) do
      delete weather_item_url(@weather_item)
    end

    assert_redirected_to weather_items_url
  end
end
