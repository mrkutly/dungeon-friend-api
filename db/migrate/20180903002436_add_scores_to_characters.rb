class AddScoresToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :strength, :integer
    add_column :characters, :constitution, :integer
    add_column :characters, :wisdom, :integer
    add_column :characters, :dexterity, :integer
    add_column :characters, :intelligence, :integer
    add_column :characters, :charisma, :integer
  end
end
