class CommentDecorator < Draper::Decorator
  delegate_all

  def created_at
    object.created_at.strftime("%y/%m/%d %H:%M")
  end

  def session_comment
    object.content + "(#{created_at})"
  end
end
