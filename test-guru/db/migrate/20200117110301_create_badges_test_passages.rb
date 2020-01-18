class CreateBadgesTestPassages < ActiveRecord::Migration[6.0]
  def change
    create_table :badges_test_passages do |t|
      t.references :badge
      t.references :test_passage
    end
  end
end
