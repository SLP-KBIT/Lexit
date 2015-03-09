class AddOptionsToUsers < ActiveRecord::Migration
  def change
    change_column_null :users, :real_name, false
    change_column_null :users, :student_code, false
  end
end
