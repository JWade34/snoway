class AddDestinationToFlight < ActiveRecord::Migration
  def change
    add_column :flights, :destination, :string
  end
end
