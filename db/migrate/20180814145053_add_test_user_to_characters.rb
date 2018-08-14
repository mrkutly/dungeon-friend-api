class AddTestUserToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :test_user_id, :integer
  end
end
