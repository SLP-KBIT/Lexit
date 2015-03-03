# == Schema Information
#
# Table name: books
#
#  id         :integer          not null, primary key
#  isbn       :string(255)
#  name       :text
#  created_at :datetime
#  updated_at :datetime
#

class Book < ActiveRecord::Base
  has_many :seminar_project_books
  has_many :seminar_project, through: :seminar_project_books
end
