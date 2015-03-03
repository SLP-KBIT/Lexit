class EntriesController < ApplicationController
  def create
    entry = Entry.new(seminar_project_id: params[:seminar_project_id], user_id: current_user.id, entry_type: params[:entry_type])
    entry.save!
    redirect_to seminar_project_path(params[:seminar_project_id])
  end
end
