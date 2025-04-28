class CreateAdmins < ActiveRecord::Migration[8.0]
  def change
    create_table :admins do |t|
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.references :hub, null: false, foreign_key: true

      t.timestamps
    end
    add_index :admins, :email, unique: true
  end
end
