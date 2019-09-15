class CreateWeatherItems < ActiveRecord::Migration[6.0]
  def change
    create_table :weather_items do |t|
      t.references :city, null: false, foreign_key: true
      t.datetime :forecast_for, null: false
      t.integer :precipitation_percentage, null: false, default: 0

      t.timestamps
    end
  end
end
