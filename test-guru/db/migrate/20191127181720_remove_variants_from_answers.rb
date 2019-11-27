class RemoveVariantsFromAnswers < ActiveRecord::Migration[6.0]
  def change
    remove_columns(:answers, :variant_2, :variant_3, :variant_4)
    rename_column(:answers, :variant_1, :body)
    rename_column(:answers, :right_answer, :correct)
    change_column(:answers, :correct, :boolean)
  end
end
