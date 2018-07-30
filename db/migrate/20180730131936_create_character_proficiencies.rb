class CreateCharacterProficiencies < ActiveRecord::Migration[5.2]
  def change
    create_table :character_proficiencies do |t|
      t.references :character, index: true
      t.references :proficiency, index: true

      t.timestamps
    end
  end
end
