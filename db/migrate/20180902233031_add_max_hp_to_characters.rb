class AddMaxHpToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :max_hp, :integer
  end
end
