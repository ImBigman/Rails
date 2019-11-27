class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.string :variant_1
      t.string :variant_2
      t.string :variant_3
      t.string :variant_4
      t.integer :right_answer

      t.timestamps
    end
  end
end
