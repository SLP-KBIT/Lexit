# == Schema Information
#
# Table name: seminar_projects
#
#  id             :integer          not null, primary key
#  title          :text
#  description    :text
#  target         :text
#  genre          :text
#  project_status :integer          default(0), not null
#  data_status    :integer          default(0), not null
#  user_id        :integer          not null
#  promotion      :text
#  created_at     :datetime
#  updated_at     :datetime
#

class SeminarProject < ActiveRecord::Base
  has_many :seminar_project_books, dependent: :destroy
  has_many :books, through: :seminar_project_books
  belongs_to :owner, foreign_key: :user_id, class_name: 'User'
  has_many :entries
  has_many :participants, through: :entries, source: :user
  has_many :seminar_sessions

  scope :is_initiate, -> { where(project_status: ProjectStatus::INITIATE) }
  scope :is_plan, -> { where(project_status: ProjectStatus::PLANNING) }

  module ProjectStatus
    INITIATE = 0
    PLANNING = 100
  end

  def initiate?
    return true if project_status == ProjectStatus::INITIATE
    false
  end

  def planning?
    return true if project_status == ProjectStatus::PLANNING
    false
  end

  def owner?(user)
    return true if user == owner
    false
  end

  def first_book=(book)
    first_book = seminar_project_books.first
    if first_book
      first_book.book_id = book.id
    else
      first_book = SeminarProjectBook.new(book_id: book.id, seminar_project_id: id)
      first_book.relation_type = SeminarProjectBook::RelationType::MAIN
    end
    first_book.save!
  end

  def determine_with_session(time)
    time.times do
      seminar_sessions.create
    end
  end

  def comments
    Comment.where(target: Comment::Target::PROJECT, target_id: id)
  end
end
