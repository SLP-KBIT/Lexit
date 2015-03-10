class SeminarSessionDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
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
end
