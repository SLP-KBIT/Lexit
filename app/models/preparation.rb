# == Schema Information
#
# Table name: preparations
#
#  id                 :integer          not null, primary key
#  seminar_session_id :integer          not null
#  book               :string(255)      not null
#  read               :string(255)      not null
#  note               :string(255)      not null
#  material           :string(255)      not null
#  practice           :integer          default(0), not null
#  created_at         :datetime
#  updated_at         :datetime
#

class Preparation < ActiveRecord::Base
  belongs_to :seminar_session

  serialize :book
  serialize :read
  serialize :note
  serialize :material
end
