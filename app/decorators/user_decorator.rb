class UserDecorator < Draper::Decorator
  delegate_all

  def name
    return object.real_name unless object.real_name.blank?
    return object.nick_name unless object.nick_name.blank?
    object.login_name
  end

  def name_with_student_code
    return name if object.student_code.blank?
    object.student_code + ' ' + name
  end
end
