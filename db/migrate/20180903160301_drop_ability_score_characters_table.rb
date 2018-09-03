class DropAbilityScoreCharactersTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :ability_score_characters
  end
end
