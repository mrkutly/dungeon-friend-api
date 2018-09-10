class RemoveMagicSchoolIdFromCharacters < ActiveRecord::Migration[5.2]
  def change
    remove_column :characters, :magic_school_id, :integer
  end
end
