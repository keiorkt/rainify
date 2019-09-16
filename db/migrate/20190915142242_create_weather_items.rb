class CreateWeatherItems < ActiveRecord::Migration[6.0]
  def change
    create_table :weather_items do |t|
      t.references :city, null: false, foreign_key: true
      t.string :weather_type, null: false
      t.datetime :start_at, null: false, index: true
      t.datetime :end_at, null: false

      t.timestamps
    end
  end
end
