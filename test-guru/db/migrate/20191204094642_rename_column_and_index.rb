class RenameColumnAndIndex < ActiveRecord::Migration[6.0]
  def change
    rename_index :user_histories, 'index_user_histories_on_tests_id', 'index_user_histories_on_test_id'
    rename_index :user_histories, 'index_user_histories_on_users_id', 'index_user_histories_on_user_id'
    rename_column :user_histories, :users_id, :user_id
    rename_column :user_histories, :tests_id, :test_id
  end
end
