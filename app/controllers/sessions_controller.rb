class SessionsController < ApplicationController
  def new
    # ログインページを返すだけ

  end

  def create
    # emailとpasswordを元にログイン処理
     @user = User.find_by(email: params[:email])
    if @user != nil && @user.password == params[:password]
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash.now.alert = 'もう一度ご記入ください'
      render :new
    end
  end

  def destroy
    # ログアウトしてログインページにリダイレクト
    session.delete(:user_id)
    redirect_to login_path
  end
end
