class CirclesController < ApplicationController
  def index
    # policiesで対応ファイル指定
    authorize Circle
    @circles = Circle.all.order(updated_at: :desc)

    # user_idを受け取る
    @user = User.find(session[:user_id])
  end

  def show
    # circleのidを受け取る
    @circle = Circle.find(params[:id])

    # policiesで対応ファイル指定
    authorize @circle

    # user_idを受け取る
    @user = User.find(session[:user_id])

    # include?メソッドは、配列の要素に引数objが含まれていればtrue
    if !@circle.members.include?(@user)
      redirect_to :back, alert: 'まだ参加してない' and return
    end

    # 最新時間の順のに並べ、変数に入れる
    @comments = @circle.comments.order(created_at: :desc)
  end

  def new
    @circle = Circle.new
  end

  def create
    @circle = Circle.new(circle_params)
    @user = User.find(session[:user_id])
    
    # saveでdbに保存
    if @circle.save

      # 作成した人をownerにする
      @circle.memberships.create(user: @user, role: :owner)
      redirect_to circles_path, notice: 'サークル作成しました'
    else
      flash.now.alert = '作成に失敗しました'
      render :new
    end
  end

  def edit
    @circle = Circle.find(params[:id])
  end

  def update
    @circle = Circle.find(params[:id])

    if @circle.update(circle_params)
      redirect_to @circle
    else
      render 'edit'
    end
  end

  def destroy
    @circle = Circle.find(params[:id])

    # policiesで対応ファイル指定
    authorize @circle
    
    @circle.destroy
    redirect_to circles_path, notice: 'サークルを消去しました'
  end

  private
    def circle_params
      params.require(:circle).permit(:name, :description)
    end
end
