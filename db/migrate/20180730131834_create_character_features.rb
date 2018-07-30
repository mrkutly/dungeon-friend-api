class CreateCharacterFeatures < ActiveRecord::Migration[5.2]
  def change
    create_table :character_features do |t|
      t.references :character, index: true
      t.references :feature, index: true

      t.timestamps
    end
  end
end
