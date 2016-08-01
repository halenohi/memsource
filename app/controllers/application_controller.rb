class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  helper_method :current_user

  rescue_from Pundit::NotAuthorizedError, with: :pundit_not_authorized

  private
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def session_user
      @user = User.find(session[:user_id])
    end

    def pundit_not_authorized
      redirect_to :back, alert: '操作が完了できませんでした'
    end

    def authenticate_user
      if current_user == nil
        redirect_to login_path, alert: 'ログインしてください'
      end
    end

end
