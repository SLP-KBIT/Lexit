class CreatePreparations < ActiveRecord::Migration
  def change
    create_table :preparations do |t|
      t.integer :seminar_session_id, null: false
      t.string :book, null: false
      t.string :read, null: false
      t.string :note, null: false
      t.string :material, null: false
      t.integer :practice, null: false, default: 0

      t.timestamps
    end
  end
end
