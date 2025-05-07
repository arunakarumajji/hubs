class CreateStorySubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :story_submissions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :challenge, null: false, foreign_key: true
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
