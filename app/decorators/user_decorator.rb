class UserDecorator < Draper::Decorator
  delegate_all

  def name
    return object.nick_name unless object.nick_name.blank?
    return object.real_name unless object.real_name.blank?
    object.login_name
  end

  def name_with_student_code
    if object.student_code.blank?
      return name
    end
    object.student_code + ' ' + name
  end
end
