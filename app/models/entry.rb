# == Schema Information
#
# Table name: entries
#
#  id                 :integer          not null, primary key
#  user_id            :integer          not null
#  seminar_project_id :integer          not null
#  entry_type         :integer          default(0), not null
#  created_at         :datetime
#  updated_at         :datetime
#

class Entry < ActiveRecord::Base
  belongs_to :seminar_project
  belongs_to :user
end
