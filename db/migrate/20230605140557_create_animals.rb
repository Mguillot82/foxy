class CreateAnimals < ActiveRecord::Migration[7.0]
  def change
    create_table :animals do |t|
      t.string :name
      t.string :scientific_name
      t.string :description
      t.string :location
      t.references :taxonomy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
