class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  def current_user
    #session 에 저장되어있는 경우
    #@user에 User를 찾아서 저장한다.
    #||=으로 저장하는 이유는, @user가 비어있는 경우에만 활용하기 위해서이다.
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end


  def authorize
      if current_user.nil?
        flash[:alert]="Login first!"
        redirect_to "/"
      end 
  end


end
