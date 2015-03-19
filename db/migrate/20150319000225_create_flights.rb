class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.decimal :price
      t.string :carrier_code
      t.string :flight_number
      t.string :carrier_name

      t.timestamps null: false
    end
  end
end
