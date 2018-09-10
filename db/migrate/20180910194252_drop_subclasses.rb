class DropSubclasses < ActiveRecord::Migration[5.2]
  def change
    drop_table :subclasses
  end
end
