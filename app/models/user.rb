# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  login_name             :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  real_name              :string(255)
#  nick_name              :string(255)
#  student_code           :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :owned_seminar_projects, class_name: 'SeminarProject'
  has_many :entries
  has_many :joined_seminar_projects, through: :entries, source: :seminar_project

  def participant?(seminar_project)
    return false if entries.is_participant.where(seminar_project_id: seminar_project.id).blank?
    true
  end

  def thinking?(seminar_project)
    return false if entries.is_thinking.where(seminar_project_id: seminar_project.id).blank?
    true
  end
end
