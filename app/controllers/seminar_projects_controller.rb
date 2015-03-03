class SeminarProjectsController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def new
    @seminar_project = SeminarProject.new
  end

  def create
    seminar_project = SeminarProject.new(seminar_project_params)
    seminar_project.user_id = current_user.id
    seminar_project.save!
    redirect_to seminar_projects_path, alert: {notice: "create new seminar project"}
  end

  def edit
  end

  private

  def seminar_project_params
    params.require(:seminar_project).permit(:title, :description, :target, :genre, :promotion)
  end
end
