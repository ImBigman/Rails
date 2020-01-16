class CreateBadges < ActiveRecord::Migration[6.0]
  def change
    create_table :badges do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.references :test_passage, foreign_key: true
      t.references :user, through: :test_passages, dependent: :destroy
      t.timestamps
    end
  end
end
