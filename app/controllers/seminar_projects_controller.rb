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
    book = Book.where(isbn:params[:isbn]).first

    unless book
      book = Book.new(isbn:params[:isbn], name: params[:book_name])
      book.save!
    end
    books = seminar_project.books.first
    if books
      books.book_id = book.id
    else
      books = SeminarProjectBook.new(book_id: book.id, seminar_project_id: seminar_project.id)
      books.relation_type = SeminarProjectBook::RelationType::MAIN
    end
    books.save!

    redirect_to seminar_projects_path, alert: {notice: "create new seminar project"}
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

    book = Book.where(isbn:params[:isbn]).first
    unless book
      book = Book.new(isbn:params[:isbn], name: params[:book_name])
      book.save!
    end
    seminar_project_books = seminar_project.seminar_project_books.first
    if seminar_project_books
      seminar_project_books.book_id = book.id
    else
      seminar_project_books = SeminarProjectBook.new(book_id: book.id, seminar_project_id: seminar_project.id)
      seminar_project_books.relation_type = SeminarProjectBook::RelationType::MAIN
    end
    seminar_project_books.save!

    redirect_to seminar_project_path(seminar_project)
  end

  private

  def seminar_project_params
    params.require(:seminar_project).permit(:title, :description, :target, :genre, :promotion, :project_status)
  end
end
