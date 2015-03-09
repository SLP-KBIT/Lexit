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
    seminar_project = SeminarProject.new(seminar_project_params)
    seminar_project.user_id = current_user.id
    seminar_project.save!

    book = find_or_create_book(params[:isbn], params[:book_name])
    seminar_project.first_book = book

    entry = Entry.new(seminar_project_id: seminar_project.id, user_id: current_user.id, entry_type: Entry::EntryType::PARTICIPATE)
    entry.save!

    redirect_to seminar_project_path(seminar_project), alert: { notice: 'create new seminar project' }
  end

  def show
    @entry = current_user.entries.where(seminar_project_id: @seminar_project.id).first
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
    @seminar_project.save
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
