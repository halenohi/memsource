class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  helper_method :current_user

  private
    def current_user
      User.find_by(id: session[:user_id])
    end

    def session_user
      @user = User.find(session[:user_id])
    end

    def circle_id
      @circle = Circle.find(params[:id])
    end
end
