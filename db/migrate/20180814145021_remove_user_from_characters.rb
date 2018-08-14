class RemoveUserFromCharacters < ActiveRecord::Migration[5.2]
  def change
    remove_column :characters, :user_id, :integer
  end
end
