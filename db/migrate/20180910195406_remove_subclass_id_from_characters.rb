class RemoveSubclassIdFromCharacters < ActiveRecord::Migration[5.2]
  def change
    remove_column :characters, :subclass_id, :integer
  end
end
