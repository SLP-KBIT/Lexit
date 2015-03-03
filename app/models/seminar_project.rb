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
end
