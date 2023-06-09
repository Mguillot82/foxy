class AddCoordinatesToCatch < ActiveRecord::Migration[7.0]
  def change
    add_column :catches, :latitude, :float
    add_column :catches, :longitude, :float
  end
end
