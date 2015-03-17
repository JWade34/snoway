class CreateHourlyForecasts < ActiveRecord::Migration
  def change
    create_table :hourly_forecasts do |t|
      t.integer :resort_id
      t.datetime :datetime
      t.decimal :temperature_min
      t.decimal :temperature_max
      t.decimal :precip_probability
      t.decimal :precip_accumulation
      t.string :summary
      t.string :precip_type


      t.timestamps null: false
    end
  end
end
