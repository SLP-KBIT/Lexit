class SeminarSessionsController < ApplicationController
  before_action :load_project, :load_session

  def show
  end

  def edit
  end

  def create
    # s = @seminar_project.seminar_sessions.build
    # s.save!
    create_with_preparation
    redirect_to seminar_project_path(@seminar_project)
  end

  def update
    store_pages('slide')
    @seminar_session.update(session_params)
    redirect_to seminar_project_path(@seminar_session.seminar_project)
  end

  def download
    send_file(@seminar_session.resume.path) if params[:type] == 'resume'
  end

  private

  def create_with_preparation
    seminar_session = @seminar_project.seminar_sessions.build
    preparation = seminar_session.prepare_preparation
    preparation.save!
    seminar_session.save!
  end

  def session_params
    params.require(:seminar_session).permit(
      :seminar_project_id, :date, :user_id, :help,
      :title, :slide, :resume, :answer
    )
  end

  def load_project
    @seminar_project = SeminarProject.find(params[:seminar_project_id]) unless params[:seminar_project_id].blank?
  end

  def load_session
    @seminar_session = SeminarSession.find(params[:id]) unless params[:id].blank?
    @seminar_session.prepare_preparation! if @seminar_session
  end

  def store_pages(type)
    file = @seminar_session.slide if type == 'slide'
    file = @seminar_session.resume if type == 'resume'
    file = @seminar_session.answer if type == 'answer'
    return unless file

    extracted = false
    mime = FileMagic.new(FileMagic::MAGIC_MIME_TYPE).file(file.current_path)
    office_extension = file.current_path.match(/(ppt|pptx|doc|docx|xls|xlsx)$/)
    if ['application/zip', 'application/vnd.ms-excel', 'application/vnd.ms-office', 'application/vnd.ms-powerpoint'].index(mime) && office_extension
      extracted = true
      office_extension = office_extension[0].gsub(/x$/, '')
      tempfile = Tempfile.new(['temp', '.' + office_extension])
      tempfile_pdf_path = tempfile.path.gsub(/\.#{office_extension}$/, '.pdf')
      begin
        tempfile.binmode
        tempfile.write file.read
        tempfile.close
        dir_prefix = 'public/uploads/seminar_session/' + type + '/' + @seminar_session.id.to_s + '/pages'
        unless Dir.exist?(dir_prefix) && Dir.exist?(dir_prefix + '-m') && Dir.exist?(dir_prefix + '-s')
          logger.debug 'Convert to pdf: ' + tempfile_pdf_path
          `unoconv -f pdf -T 60 "#{tempfile.path}"`
          unless Dir.exist?(dir_prefix)
            Dir.mkdir(dir_prefix, 0755)
            logger.debug 'Generate thumbnails'
            `convert -density 300 "#{tempfile_pdf_path}" #{Rails.root}/#{dir_prefix}/%03d.png`
          end
          unless Dir.exist?(dir_prefix + '-m')
            logger.debug 'Generate medium thumbnails'
            Dir.mkdir(dir_prefix + '-m', 0755)
            `convert -density 75 "#{tempfile_pdf_path}" #{Rails.root}/#{dir_prefix}-m/%03d.png`
          end
          unless Dir.exist?(dir_prefix + '-s')
            logger.debug 'Generate small thumbnails'
            Dir.mkdir(dir_prefix + '-s', 0755)
            `convert -resize 240x "#{tempfile_pdf_path}" #{Rails.root}/#{dir_prefix}-s/%03d.png`
          end
        end

        begin
          File.unlink(tempfile_pdf_path) if File.exist?(tempfile_pdf_path)
        rescue
        end
      rescue
        tempfile.unlink
      end
    end

    return unless extracted

    # save extracted files information to JSON
    files = Dir.glob(Rails.root.to_s + '/public/uploads/seminar_session/' + type + '/' + @seminar_session.id.to_s + '/pages/*').sort
    files.map! do |file_path|
      File.basename(file_path)
    end
    files_status = {}
    files.each do |file_name|
      files_status[file_name] = 'open'
    end
    @seminar_session.slide_status_json = JSON.generate(files_status)
  end
end
