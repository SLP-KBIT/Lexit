class CreatePreparations < ActiveRecord::Migration
  def change
    create_table :preparations do |t|
      t.integer :seminar_session_id, null: false
      t.json :book, null: false
      t.json :read, null: false
      t.json :note, null: false
      t.json :material, null: false
      t.integer :practice, null: false, default: 0

      t.timestamps
    end
  end
end
