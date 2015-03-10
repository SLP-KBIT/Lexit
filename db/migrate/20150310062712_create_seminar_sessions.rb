class CreateSeminarSessions < ActiveRecord::Migration
  def change
    create_table :seminar_sessions do |t|
      t.integer :user_id
      t.integer :seminar_project_id, null: false
      t.datetime :date
      t.boolean :help, null: false, default: false
      t.boolean :end, null: false, default: false

      t.timestamps
    end
  end
end
