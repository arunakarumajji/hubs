class CreateActivities < ActiveRecord::Migration[8.0]
  def change
    create_table :activities do |t|
      t.string :action
      t.references :user, null: false, foreign_key: true
      t.references :hub, null: false, foreign_key: true
      t.references :trackable, polymorphic: true, null: false
      t.json :data

      t.timestamps
    end
  end
end
