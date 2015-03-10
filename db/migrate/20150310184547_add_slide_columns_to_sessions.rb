class AddSlideColumnsToSessions < ActiveRecord::Migration
  def change
    add_column :seminar_sessions, :slide, :string
    add_column :seminar_sessions, :resume, :string
    add_column :seminar_sessions, :answer, :string
    add_column :seminar_sessions, :slide_status_json, :text
    add_column :seminar_sessions, :resume_status_json, :text
    add_column :seminar_sessions, :answer_status_json, :text
  end
end
