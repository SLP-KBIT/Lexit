class CreateSeminarProjects < ActiveRecord::Migration
  def change
    create_table :seminar_projects do |t|
      t.text :title
      t.text :description
      t.text :target
      t.text :genre
      t.integer :project_status, null: false, default: 0
      t.integer :data_status, null: false, default: 0
      t.integer :user_id, null: false
      t.text :promotion

      t.timestamps
    end
  end
end
