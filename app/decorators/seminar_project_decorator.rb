class SeminarProjectDecorator < Draper::Decorator
  delegate_all

  def description
    object.description.gsub(/</, '&lt;').gsub(/>/, '&gt;').gsub(/&/, '&amp;').gsub(/\n/, '<br/>')
  end

  def book_name(empty = false)
    if object.books.count > 0
      name = object.books.first.name
      if name.blank?
        return '書籍名が未設定' unless empty
        ''
      else
        name
      end
    else
      return '書籍が未設定' unless empty
      ''
    end
  end

  def isbn
    if object.books.count > 0
      isbn = object.books.first.name
      if isbn.blank?
        ''
      else
        isbn
      end
    else
      ''
    end
  end
end
