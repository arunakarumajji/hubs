class RenameTypeColumnInChallenges < ActiveRecord::Migration[8.0]
  def change
    # Rename the 'type' column to 'challenge_type'
    rename_column :challenges, :type, :challenge_type

    # Add an index to the new 'challenge_type' column
    add_index :challenges, :challenge_type
  end
end
