class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.references :user, index: true
      t.references :race, index: true
      t.references :job, index: true
      t.string :name
      t.references :magic_school, index: true
      t.references :subclass, index: true
      t.references :subrace, index: true
      t.integer :level

      t.timestamps
    end
  end
end
