class SeminarProjectDecorator < Draper::Decorator
  delegate_all

  def description
    object.description.gsub(/</, '&lt;').gsub(/>/, '&gt;').gsub(/&/, '&amp;').gsub(/\n/, '<br/>')
  end

end
