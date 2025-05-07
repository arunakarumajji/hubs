class AddChallengeTypeAndExecutionSettingsToChallenge < ActiveRecord::Migration[8.0]
  def change
    add_column :challenges, :execution_limit, :integer
    add_column :challenges, :type, :integer
  end
end
