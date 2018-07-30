class CreateCharacterSpells < ActiveRecord::Migration[5.2]
  def change
    create_table :character_spells do |t|
      t.references :character, index: true
      t.references :spell, index: true

      t.timestamps
    end
  end
end
