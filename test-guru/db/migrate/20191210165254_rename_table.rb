class RenameTable < ActiveRecord::Migration[6.0]
  def change
    add_column :user_histories, :correct_questions, :integer, default: 0
    rename_table :user_histories, :test_passages
    add_reference(:test_passages, :current_question, foreign_key: { to_table: :questions } )
  end
end
