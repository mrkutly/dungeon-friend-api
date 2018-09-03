class AddScoreToAbilityScoreCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :ability_score_characters, :score, :integer
  end
end
