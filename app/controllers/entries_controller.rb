class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_entry
  def create
    @entry.destroy unless @entry.nil?
    entry = Entry.new(seminar_project_id: params[:seminar_project_id], user_id: current_user.id, entry_type: params[:entry_type])
    entry.save!
    redirect_to seminar_project_path(params[:seminar_project_id])
  end

  def destroy
    @entry.destroy
    redirect_to seminar_project_path(params[:seminar_project_id])
  end

  private

  def load_entry
    @entry = Entry.where(seminar_project_id: params[:seminar_project_id], user_id: current_user.id).first
  end
end
