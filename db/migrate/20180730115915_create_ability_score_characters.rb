class CreateAbilityScoreCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :ability_score_characters do |t|
      t.references :character, index: true
      t.references :ability_score, index: true

      t.timestamps
    end
  end
end
