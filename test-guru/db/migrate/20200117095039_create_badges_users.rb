class CreateBadgesUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :badges_users do |t|
      t.references :user
      t.references :badge
    end
  end
end
