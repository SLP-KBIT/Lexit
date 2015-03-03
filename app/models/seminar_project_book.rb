# == Schema Information
#
# Table name: seminar_project_books
#
#  id                 :integer          not null, primary key
#  book_id            :integer          not null
#  seminar_project_id :integer          not null
#  relation_type      :integer          default(0), not null
#  created_at         :datetime
#  updated_at         :datetime
#

class SeminarProjectBook < ActiveRecord::Base
  belongs_to :seminar_project
  belongs_to :book
end
