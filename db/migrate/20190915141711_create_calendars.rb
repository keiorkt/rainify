class CreateCalendars < ActiveRecord::Migration[6.0]
  def change
    create_table :calendars do |t|
      t.string :summary, null: false
      t.string :owner_identifier, null: false, unique: true
      t.boolean :notify, null: false, default: false
      t.boolean :is_primary, null: false, default: false

      t.timestamps
    end
  end
end
