class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.references :hub, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
