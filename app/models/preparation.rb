# == Schema Information
#
# Table name: preparations
#
#  id                 :integer          not null, primary key
#  seminar_session_id :integer          not null
#  book               :json             not null
#  read               :json             not null
#  note               :json             not null
#  material           :json             not null
#  practice           :integer          default(0), not null
#  created_at         :datetime
#  updated_at         :datetime
#

class Preparation < ActiveRecord::Base
  belongs_to :seminar_session

  serialize :book, JsonLoader.new
  serialize :read, JsonLoader.new
  serialize :note, JsonLoader.new
  serialize :material, JsonLoader.new
end
