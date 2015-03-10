class SeminarSessionsController < ApplicationController
  def show
  end

  def create
    create_with_preparation
    redirect_to seminar_project_path(id: session_params[:seminar_project_id])
  end

  private

  # def create_with_preparation
  #   seminar_project = SeminarProject.find(session_params[:seminar_project_id])
  #   seminar_session = seminar_project.seminar_session.build(session_params)
  #   preparation = prep_init(seminar_session)
  #   preparation.save!
  #   seminar_session.save!
  # end

  # def session_params
  #   prams.permit(:seminar_session).require(:seminar_project_id, :date, :user_id, :help)
  # end

  # def prep_init(seminar_session)
  #   p = seminar_session.build_preparation
  #   p.book = { seminar_session.book.name => false }
  #   p.read = { '0章0節' => false }
  #   p.note = { '0章0節' => false }
  #   p.material = { '章構成' => false, 'レイアウト' => false, '図解' => false }
  #   p
  # end
end
