class CreateEmailConfigs < ActiveRecord::Migration[8.0]
  def change
    create_table :email_configs do |t|
      t.string :subject
      t.text :body
      t.string :from_email
      t.references :hub, null: false, foreign_key: true

      t.timestamps
    end
  end
end
