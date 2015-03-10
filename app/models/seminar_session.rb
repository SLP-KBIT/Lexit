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
#

class SeminarSession < ActiveRecord::Base
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
end
