class AddSomeFieldsToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :name, :login_name
    add_column :users, :real_name, :string
    add_column :users, :nick_name, :string
    add_column :users, :student_code, :string
  end
end
