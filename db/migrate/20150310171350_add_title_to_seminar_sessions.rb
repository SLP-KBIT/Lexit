class AddTitleToSeminarSessions < ActiveRecord::Migration
  def change
    add_column :seminar_sessions, :title, :text
  end
end
