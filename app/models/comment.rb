# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  target     :integer          not null
#  target_id  :integer          not null
#  content    :text             not null
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  belongs_to :user

  module Target
    PROJECT = 0
    SESSION = 50
    SESSION_SLIDE = 100
  end
end
