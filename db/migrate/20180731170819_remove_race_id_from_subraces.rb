class RemoveRaceIdFromSubraces < ActiveRecord::Migration[5.2]
  def change
    remove_column :subraces, :race_id, :bigint
  end
end
