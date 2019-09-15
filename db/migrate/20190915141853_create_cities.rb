class CreateCities < ActiveRecord::Migration[6.0]
  def change
    create_table :cities do |t|
      t.string :name, unique: true
      t.boolean :is_current_location, null: false, default: false

      t.timestamps
    end
  end
end
