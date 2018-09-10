class DropDamageTypes < ActiveRecord::Migration[5.2]
  def change
    drop_table :damage_types
  end
end
