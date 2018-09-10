class DropMagicSchools < ActiveRecord::Migration[5.2]
  def change
    drop_table :magic_schools
  end
end
