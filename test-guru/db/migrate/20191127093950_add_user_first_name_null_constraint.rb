class AddUserFirstNameNullConstraint < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:users, :first_name, false)
    change_column_null(:users, :second_name, false)
    change_column_null(:users, :login, false)
    change_column_null(:users, :email, false)
  end
end
