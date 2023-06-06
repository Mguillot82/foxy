class AddPhotoToAnimals < ActiveRecord::Migration[7.0]
  def change
    add_column :animals, :photo_url, :string
  end
end
