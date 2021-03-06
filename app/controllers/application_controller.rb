class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:login_name, :email, :password, :password_confirmation, :admin, :real_name, :nick_name, :student_code)
    end
    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:login_name, :email, :password, :remember_me, :real_name, :nick_name, :student_code)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:login_name, :email, :password, :password_confirmation, :admin, :real_name, :nick_name, :student_code, :current_password)
    end
  end

  private

  def sign_in_required
    redirect_to new_user_session_path unless user_signed_in?
  end
end
