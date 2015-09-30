describe SeminarProject, type: :model do
  describe '#determine_with_session' do
    before { @project = create(:seminar_project, user_id: 1) }
    it '1つのseminar_sessionsが生成される' do
      @project.determine_with_session(1)
      expect(@project.seminar_sessions.count).to eq 1
    end
    it '2つのseminar_sessionsが生成される' do
      @project.determine_with_session(2)
      expect(@project.seminar_sessions.count).to eq 2
    end
  end
end
