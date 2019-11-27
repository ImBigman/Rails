class AddAnswersColumnDefault < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:answers, :right_answer, 'variant_1')
  end
end
