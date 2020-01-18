class CreateBadges < ActiveRecord::Migration[6.0]
  def change
    create_table :badges do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.string :kind, null: false
      t.timestamps
    end
  end
end
