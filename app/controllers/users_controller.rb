class UsersController < ApplicationController
  def new
    # HTMLから受け取る場合@が必要
    @user = User.new
  end

  def create
    @user = User.new(params[:user].permit(:email, :name, :password, :password_confirmation))
    if @user.save
      # 作成成功
      # ログイン
      session[:user_id] = user.id
      redirect_to root_path
    else
      # 作成失敗
      flash.now.alert = 'もう一度ご記入ください'
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    # ログアウト
    session.delete(:user_id)
    redirect_to login_path
  end

  private
    # 現在のuserを取得
    # @_current_userが空の場合は、session情報をキーにしてDBから検索する
    def current_user
      @_current_user ||= User.find_by(id: session[:user_id])
    end

end
