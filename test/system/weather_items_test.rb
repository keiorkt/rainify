require "application_system_test_case"

class WeatherItemsTest < ApplicationSystemTestCase
  setup do
    @weather_item = weather_items(:one)
  end

  test "visiting the index" do
    visit weather_items_url
    assert_selector "h1", text: "Weather Items"
  end

  test "creating a Weather item" do
    visit weather_items_url
    click_on "New Weather Item"

    fill_in "City", with: @weather_item.city_id
    fill_in "Forecast for", with: @weather_item.forecast_for
    fill_in "Precipitation percentage", with: @weather_item.precipitation_percentage
    click_on "Create Weather item"

    assert_text "Weather item was successfully created"
    click_on "Back"
  end

  test "updating a Weather item" do
    visit weather_items_url
    click_on "Edit", match: :first

    fill_in "City", with: @weather_item.city_id
    fill_in "Forecast for", with: @weather_item.forecast_for
    fill_in "Precipitation percentage", with: @weather_item.precipitation_percentage
    click_on "Update Weather item"

    assert_text "Weather item was successfully updated"
    click_on "Back"
  end

  test "destroying a Weather item" do
    visit weather_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Weather item was successfully destroyed"
  end
end
