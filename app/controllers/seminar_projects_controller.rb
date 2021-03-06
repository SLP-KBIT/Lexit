class SeminarProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_seminar_project
  before_action :authenticate_owner, only: [:edit, :update]

  def index
  end

  def new
    @seminar_project = SeminarProject.new
  end

  def create
    current_user_id = current_user.id
    seminar_project = SeminarProject.create!(seminar_project_params.merge user_id: current_user_id)
    seminar_project.first_book = find_or_create_book(params[:isbn], params[:book_name])

    Entry.create!(
      seminar_project: seminar_project,
      user_id: current_user_id,
      entry_type: Entry::EntryType::PARTICIPATE
    )

    redirect_to seminar_project_path(seminar_project), alert: { notice: 'create new seminar project' }
  end

  def show
    @entry = current_user.entries.where(seminar_project_id: @seminar_project.id).first
    @project_comment = Comment.new(user_id: current_user.id, target: Comment::Target::PROJECT, target_id: @seminar_project.id)
    @session_comment = Comment.new(user_id: current_user.id, target: Comment::Target::SESSION)
  end

  def edit
    redirect_to root_path unless @seminar_project
  end

  def update
    redirect_to root_path unless @seminar_project
    @seminar_project.update_attributes(seminar_project_params)

    book = find_or_create_book(params[:isbn], params[:book_name])
    @seminar_project.first_book = book

    redirect_to seminar_project_path(@seminar_project)
  end

  def determine
    @seminar_project.project_status = SeminarProject::ProjectStatus::PLANNING
    @seminar_project.save!
    @seminar_project.determine_with_session(params['seminar_session']['number'].to_i)
    redirect_to seminar_project_path(@seminar_project), notice: 'プロジェクトを確定しました'
  end

  private

  def seminar_project_params
    params.require(:seminar_project).permit(:title, :description, :target, :genre, :promotion)
  end

  def find_or_create_book(isbn, book_name)
    book = Book.where(isbn: isbn).first
    unless book
      book = Book.new(isbn: isbn, name: book_name)
      book.save!
    end
    book
  end

  def load_seminar_project
    @seminar_project = SeminarProject.find(params[:id]) unless params[:id].blank?
  end

  def authenticate_owner
    return unless @seminar_project
    @seminar_project = nil unless @seminar_project.user_id == current_user.id
  end
end
