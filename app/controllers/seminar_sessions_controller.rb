class SeminarSessionsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_project, :load_session

  def show
  end

  def edit
  end

  def create
    @seminar_project.seminar_sessions.create
    redirect_to seminar_project_path(@seminar_project)
  end

  def update
    @seminar_session.update(session_params)
    store_pages!('slide')
    redirect_to seminar_project_path(@seminar_session.seminar_project)
  end

  def download
    send_file(@seminar_session.resume.path) if params[:type] == 'resume'
  end

  private

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

  def store_pages!(type)
    file = @seminar_session.document(type)
    return if file.blank?

    extracted = false
    mime = FileMagic.new(FileMagic::MAGIC_MIME_TYPE).file(file.current_path)
    office_extension = file.current_path.match(/(ppt|pptx|doc|docx|xls|xlsx)$/)
    if ['application/zip', 'application/vnd.ms-excel', 'application/vnd.ms-office', 'application/vnd.ms-powerpoint', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/vnd.ms-word.document.macroEnabled.12', 'application/vnd.openxmlformats-officedocument.wordprocessingml.template', 'application/vnd.ms-word.template.macroEnabled.12', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'application/vnd.ms-excel.sheet.macroEnabled.12', 'application/vnd.openxmlformats-officedocument.spreadsheetml.template', 'application/vnd.ms-excel.template.macroEnabled.12', 'application/vnd.ms-excel.sheet.binary.macroEnabled.12', 'application/vnd.ms-excel.addin.macroEnabled.12', 'application/vnd.openxmlformats-officedocument.presentationml.presentation', 'application/vnd.ms-powerpoint.presentation.macroEnabled.12', 'application/vnd.openxmlformats-officedocument.presentationml.slideshow', 'application/vnd.ms-powerpoint.slideshow.macroEnabled.12', 'application/vnd.openxmlformats-officedocument.presentationml.template', 'application/vnd.ms-powerpoint.template.macroEnabled.12'].index(mime) && office_extension
      extracted = true
      office_extension = office_extension[0].gsub(/x$/, '')
      tempfile = Tempfile.new(['temp', '.' + office_extension])
      tempfile_pdf_path = tempfile.path.gsub(/\.#{office_extension}$/, '.pdf')
      begin
        tempfile.binmode
        tempfile.write file.read
        tempfile.close
        generate_thumbnails(type, tempfile.path, tempfile_pdf_path)

        begin
          File.unlink(tempfile_pdf_path) if File.exist?(tempfile_pdf_path)
        rescue
        end
      ensure
        tempfile.unlink
      end
    elsif mime == 'application/pdf'
      extracted = true
      dir_prefix = "public/uploads/seminar_session/#{ type }/#{ @seminar_session.id }/pages"
      generate_large_thumbnails(file.current_path, dir_prefix)
      generate_medium_thumbnails(file.current_path, dir_prefix)
      generate_small_thumbnails(file.current_path, dir_prefix)
    end

    return unless extracted

    store_files_status(type)
    @seminar_session.save
  end

  def generate_thumbnails(type, file_path, pdf_path)
    dir_prefix = "public/uploads/seminar_session/#{ type }/#{ @seminar_session.id }/pages"
    return if Dir.exist?(dir_prefix) && Dir.exist?(dir_prefix + '-m') && Dir.exist?(dir_prefix + '-s')

    logger.debug "Convert to pdf: #{ pdf_path }"
    `unoconv -f pdf -T 60 "#{file_path}"`
    generate_large_thumbnails(pdf_path, dir_prefix)
    generate_medium_thumbnails(pdf_path, dir_prefix)
    generate_small_thumbnails(pdf_path, dir_prefix)
  end

  def generate_large_thumbnails(pdf_path, dir_prefix)
    FileUtils.rm_rf( dir_prefix ) if Dir.exist?(dir_prefix)
    Dir.mkdir(dir_prefix, 0755)
    logger.debug 'Generate thumbnails'
    `convert -density 300 "#{pdf_path}" #{Rails.root}/#{dir_prefix}/%03d.png`
  end

  def generate_medium_thumbnails(pdf_path, dir_prefix)
    FileUtils.rm_rf( dir_prefix + '-m' ) if Dir.exist?(dir_prefix + '-m')
    Dir.mkdir("#{ dir_prefix }-m", 0755)
    logger.debug 'Generate medium thumbnails'
    `convert -density 75 "#{pdf_path}" #{Rails.root}/#{dir_prefix}-m/%03d.png`
  end

  def generate_small_thumbnails(pdf_path, dir_prefix)
    FileUtils.rm_rf( dir_prefix + '-s' ) if Dir.exist?(dir_prefix + '-s')
    Dir.mkdir("#{ dir_prefix }-s", 0755)
    logger.debug 'Generate small thumbnails'
    `convert -resize 240x "#{pdf_path}" #{Rails.root}/#{dir_prefix}-s/%03d.png`
  end

  def store_files_status(type)
    files = Dir.glob("#{ Rails.root }/public/uploads/seminar_session/#{ type }/#{ @seminar_session.id }/pages/*").sort
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
