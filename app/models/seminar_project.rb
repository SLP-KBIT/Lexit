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

  scope :is_initiate, -> { where( project_status: ProjectStatus::INITIATE ) }
  scope :is_plan, -> { where( project_status: ProjectStatus::PLANNING ) }

  module ProjectStatus
    INITIATE = 0
    PLANNING = 100
  end

  def owner?(user)
    return true if user == self.owner
    return false
  end
end
