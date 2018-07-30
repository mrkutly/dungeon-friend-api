class CreateCharacterEquipments < ActiveRecord::Migration[5.2]
  def change
    create_table :character_equipments do |t|
      t.references :character, index: true
      t.references :equipment, index: true

      t.timestamps
    end
  end
end
