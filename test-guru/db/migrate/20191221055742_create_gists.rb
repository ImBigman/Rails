class CreateGists < ActiveRecord::Migration[6.0]
  def change
    create_table :gists do |t|
      t.integer :question_id
      t.string :question_body
      t.string :url
      t.string :user

      t.timestamps
    end
  end
end
