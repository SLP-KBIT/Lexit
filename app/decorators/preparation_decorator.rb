class PreparationDecorator < Draper::Decorator
  delegate_all

  def book
    object.book.each do |key, value|
      state = value == true ? '完' : '未'
      key + ' ' + state
    end
  end
end
