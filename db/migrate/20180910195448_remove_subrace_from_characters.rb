class RemoveSubraceFromCharacters < ActiveRecord::Migration[5.2]
  def change
    remove_column :characters, :subrace_id, :integer
  end
end
