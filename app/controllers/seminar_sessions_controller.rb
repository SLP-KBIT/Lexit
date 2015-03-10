class SeminarSessionsController < ApplicationController
  before_action :load_project, :load_session

  def show
  end

  def edit
  end

  def create
    # s = @seminar_project.seminar_sessions.build
    # s.save!
    create_with_preparation
    redirect_to seminar_project_path(@seminar_project)
  end

  def update
    @seminar_session.update(session_params)
    redirect_to seminar_project_path(@seminar_session.seminar_project)
  end

  def download
    send_file(@seminar_session.resume.path) if params[:type] == 'resume'
  end

  private

  def create_with_preparation
    seminar_session = @seminar_project.seminar_sessions.build
    preparation = seminar_session.prepare_preparation
    preparation.save!
    seminar_session.save!
  end

  def session_params
    params.require(:seminar_session).permit(:seminar_project_id, :date, :user_id, :help, :title, :slide, :resume, :answer)
  end

  def load_project
    @seminar_project = SeminarProject.find(params[:seminar_project_id]) unless params[:seminar_project_id].blank?
  end

  def load_session
    @seminar_session = SeminarSession.find(params[:id]) unless params[:id].blank?
    @seminar_session.prepare_preparation! if @seminar_session
  end
end
