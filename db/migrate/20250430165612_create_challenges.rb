class CreateChallenges < ActiveRecord::Migration[8.0]
  def change
    create_table :challenges do |t|
      t.string :title
      t.text :description
      t.string :sharing_link
      t.integer :points
      t.references :hub, null: false, foreign_key: true

      t.timestamps
    end
  end
end
