class AddAnswersNullConstraint < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:answers, :variant_1, false)
    change_column_null(:answers, :variant_2, false)
    change_column_null(:answers, :variant_3, false)
    change_column_null(:answers, :variant_4, false)
    change_column_null(:answers, :right_answer, false)
  end
end
