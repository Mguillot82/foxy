class CreateCollectionsCatches < ActiveRecord::Migration[7.0]
  def change
    create_table :collections_catches do |t|
      t.references :collection, null: false, foreign_key: true
      t.references :catch, null: false, foreign_key: true

      t.timestamps
    end
  end
end
