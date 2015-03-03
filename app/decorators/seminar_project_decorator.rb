class SeminarProjectDecorator < Draper::Decorator
  delegate_all

  def description
    object.description.gsub(/</, '&lt;').gsub(/>/, '&gt;').gsub(/&/, '&amp;').gsub(/\n/, '<br/>')
  end

  def book_name
    if object.books.count > 0
      name = object.books.first.name
      if name.blank?
        '書籍名が未設定'
      else
        name
      end
    else
      '書籍が未設定'
    end
  end

end
