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

class SeminarSession < ActiveRecord::Base
  mount_uploader :slide, DocumentUploader
  mount_uploader :resume, DocumentUploader
  mount_uploader :answer, DocumentUploader
  has_one :preparation
  belongs_to :seminar_project
  belongs_to :presenter, foreign_key: :user_id, class_name: User
  has_many :seminar_sessions

  def prepare_preparation
    return preparation if preparation
    prep = build_preparation
    prep.book = { seminar_project.books.first.name => false }
    prep.read = { '0章0節' => false }
    prep.note = { '0章0節' => false }
    prep.material = { '章構成' => false, 'レイアウト' => false, '図解' => false }
    prep
  end

  def prepare_preparation!
    prepare_preparation.save!
  end

  def presenter?(user)
    return true if presenter == user
    false
  end

  def document(type)
    return nil unless %w(slide resume answer).index(type)
    return slide if type == 'slide'
    return resume if type == 'resume'
    return answer if type == 'answer'
    nil
  end
end
