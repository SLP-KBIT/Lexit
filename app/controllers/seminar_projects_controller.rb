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

    book = find_or_create_book(params[:isbn], params[:book_name])
    seminar_project.first_book = book

    redirect_to seminar_projects_path, alert: { notice: 'create new seminar project' }
  end

  def show
    @seminar_project = SeminarProject.find(params[:id])
  end

  def edit
    @seminar_project = SeminarProject.find(params[:id])
  end

  def update
    seminar_project = SeminarProject.find(params[:id])
    seminar_project.update_attributes(seminar_project_params)

    book = find_or_create_book(params[:isbn], params[:book_name])
    seminar_project.first_book = book

    redirect_to seminar_project_path(seminar_project)
  end

  private

  def seminar_project_params
    params.require(:seminar_project).permit(:title, :description, :target, :genre, :promotion, :project_status)
  end

  def find_or_create_book(isbn, book_name)
    book = Book.where(isbn: isbn).first
    unless book
      book = Book.new(isbn: isbn, name: book_name)
      book.save!
    end
    book
  end
end
