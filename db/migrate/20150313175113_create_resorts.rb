class CreateResorts < ActiveRecord::Migration
  def change
    create_table :resorts do |t|
      t.string :name
      t.string :lat
      t.string :lng
      t.string :photo

      t.timestamps null: false
    end
  end
end
