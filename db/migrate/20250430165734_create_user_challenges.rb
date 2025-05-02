class CreateUserChallenges < ActiveRecord::Migration[8.0]
  def change
    create_table :user_challenges do |t|
      t.references :user, null: false, foreign_key: true
      t.references :challenge, null: false, foreign_key: true
      t.boolean :completed
      t.integer :points_awarded

      t.timestamps
    end
  end
end
