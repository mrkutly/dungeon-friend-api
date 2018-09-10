class DropTestUsers < ActiveRecord::Migration[5.2]
  def change
    drop_table :test_users
  end
end
