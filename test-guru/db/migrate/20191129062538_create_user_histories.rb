class CreateUserHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :user_histories do |t|
      t.string :user
      t.string :tests
      t.boolean :completed

      t.timestamps
    end
    add_reference(:user_histories, :users, foreign_key: true)
    add_reference(:user_histories, :tests, foreign_key: true)
  end
end
