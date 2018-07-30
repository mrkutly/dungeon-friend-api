class CreateSubclasses < ActiveRecord::Migration[5.2]
  def change
    create_table :subclasses do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
