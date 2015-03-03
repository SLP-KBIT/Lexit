class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer   :user_id, null: false
      t.integer   :seminar_project_id, null: false
      t.integer   :entry_type, null: false, default: 0

      t.timestamps
    end
  end
end
