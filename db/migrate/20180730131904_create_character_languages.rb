class CreateCharacterLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :character_languages do |t|
      t.references :character, index: true
      t.references :language, index: true

      t.timestamps
    end
  end
end
