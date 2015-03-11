class SeminarSessionDecorator < Draper::Decorator
  delegate_all

  WDATE = %w(日 月 火 水 木 金 土 日)
  def presenter
    return '未定' if object.presenter.blank?
    object.presenter.real_name
  end

  def date
    return '未定' if object.date.blank?
    wday = WDATE[object.date.wday]
    object.date.strftime("%Y.%M.%d(#{wday})")
  end

  def title
    return 'タイトル未定' if object.title.blank?
    object.title
  end

  def slide_status
    JSON.parse(slide_status_json)
  end
end
