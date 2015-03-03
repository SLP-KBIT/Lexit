class CreateSeminarProjectBooks < ActiveRecord::Migration
  def change
    create_table :seminar_project_books do |t|
      t.integer    :book_id, null: false
      t.integer    :seminar_project_id, null: false
      t.integer    :relation_type, null: false, default: 0

      t.timestamps
    end
  end
end
