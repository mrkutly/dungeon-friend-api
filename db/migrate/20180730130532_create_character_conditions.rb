class CreateCharacterConditions < ActiveRecord::Migration[5.2]
  def change
    create_table :character_conditions do |t|
      t.references :character, index: true
      t.references :condition, index: true

      t.timestamps
    end
  end
end
