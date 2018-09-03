class AddCurrentHpToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :current_hp, :integer
  end
end
