class SeminarSessionsController < ApplicationController
  before_action :load_project

  def show
  end

  def create
    # s = @seminar_project.seminar_sessions.build
    # s.save!
    create_with_preparation
    redirect_to seminar_project_path(@seminar_project)
  end

  private

  def create_with_preparation
    seminar_session = @seminar_project.seminar_sessions.build
    preparation = prep_init(seminar_session)
    byebug
    preparation.save!
    seminar_session.save!
  end

  def session_params
    params.require(:seminar_session).permit(:seminar_project_id, :date, :user_id, :help)
  end

  def prep_init(seminar_session)
    p = seminar_session.build_preparation
    p.book = { seminar_session.seminar_project.books.first.name => false }
    p.read = { '0章0節' => false }
    p.note = { '0章0節' => false }
    p.material = { '章構成' => false, 'レイアウト' => false, '図解' => false }
    p
  end

  def load_project
    @seminar_project = SeminarProject.find(params[:seminar_project_id]) unless params[:seminar_project_id].blank?
  end
end
