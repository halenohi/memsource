class UsersController < ApplicationController
  def new
  end

  def create
    # {
    #   user: {
    #     email: "",
    #     name: "",
    #     password: ""
    #     password_confirmation: ""
    #   }
    # }
    user = User.new(params[:user].permit(:email, :name, :password, :password_confirmation))
    if user.save
      # 作成成功
      redirect_to root_path
    else
      # 作成失敗
      render :new
    end
    # user = User.find_by(email: params[:session][:email].downcase)
    # if user && user.authenticate(params[:session][:password])
    # else
    #   flash[:danger] = 'Invalid email/password combination'
    #   render 'new'
    # end
  end

  def destroy
  end
end
