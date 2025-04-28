class CreateHubs < ActiveRecord::Migration[8.0]
  def change
    create_table :hubs do |t|
      t.string :name
      t.text :description
      t.string :slug

      t.timestamps
    end
  end
end
