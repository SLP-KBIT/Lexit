class UserDecorator < Draper::Decorator
  delegate_all

  def name
    return object.nick_name unless object.nick_name.blank?
    return object.real_name unless object.real_name.blank?
    object.login_name
  end

end
