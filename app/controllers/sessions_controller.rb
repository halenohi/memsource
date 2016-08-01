class SessionsController < ApplicationController
  def new
    # ログインページを返すだけ
    @user = User.new
  end

  def create
    # emailとpasswordを元にログイン処理
    @user = User.find_by(email: credentials[:email])
    # Rails.logger.debug '---------------'
    # Rails.logger.debug credentials.to_json

    if @user != nil && @user.password == credentials[:password]
      session[:user_id] = @user.id
      # layout/application.htmlから呼び出す
      redirect_to circles_path, notice: 'ログインしました'
    else
      # layout/application.htmlから呼び出す
      flash.now.alert = 'もう一度ご記入ください'
      render :new
    end
  end

  def destroy
    # ログアウトしてログインページにリダイレクト
    session.delete(:user_id)
    redirect_to login_path, notice: 'ログアウトしました'
  end

  # sessionから取得データに条件をつける
  private
    def credentials
      params.require(:session).permit(:email, :password)
    end
end
