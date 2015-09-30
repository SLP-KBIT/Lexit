# == Schema Information
#
# Table name: seminar_sessions
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  seminar_project_id :integer          not null
#  date               :datetime
#  help               :boolean          default(FALSE), not null
#  end                :boolean          default(FALSE), not null
#  created_at         :datetime
#  updated_at         :datetime
#  title              :text
#  slide              :string(255)
#  resume             :string(255)
#  answer             :string(255)
#  slide_status_json  :text
#  resume_status_json :text
#  answer_status_json :text
#

FactoryGirl.define do
  factory :seminar_session do
  end
end
