class AddSpeedToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :speed, :integer
  end
end
