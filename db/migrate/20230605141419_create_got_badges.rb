class CreateGotBadges < ActiveRecord::Migration[7.0]
  def change
    create_table :got_badges do |t|
      t.references :user, null: false, foreign_key: true
      t.references :badge, null: false, foreign_key: true

      t.timestamps
    end
  end
end
