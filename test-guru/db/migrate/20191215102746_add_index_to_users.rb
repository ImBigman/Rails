class AddIndexToUsers < ActiveRecord::Migration[6.0]
  def change
    add_index :users, %i[first_name last_name], unique: true
    add_index :users, %i[login email], unique: true
  end
end
