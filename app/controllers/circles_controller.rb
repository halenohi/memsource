class CirclesController < ApplicationController
  before_action :set_circle, only: [:show, :edit, :update, :destroy]
  def index
    # policiesで対応ファイル指定
    authorize Circle
    @circles = Circle.all.order(updated_at: :desc)
  end

  def show
    # circleのidを受け取る

    # policiesで対応ファイル指定
    # authorize @circle

    # include?メソッドは、配列の要素に引数objが含まれていればtrue
    if !@circle.members.include?(current_user)
      redirect_to :back, alert: 'まだ参加してない' and return
    end

    # 最新時間の順のに並べ、変数に入れる
    @comments = @circle.comments.order(created_at: :desc)
  end

  def new
    @circle = Circle.new
    authorize @circle
  end

  def create
    @circle = Circle.new(circle_params)
    authorize @circle

    begin
      ActiveRecord::Base.transaction do
        @circle.save!
        @circle.memberships.create!(user: current_user, role: :owner)
      end
      redirect_to circles_path, notice: 'サークル作成しました'
    rescue => e
      logger.error e.inspect + e.backtrace.join("\n")
      flash.now.lert = '作成に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
    if @circle.update(circle_params)
      redirect_to @circle
    else
      render 'edit'
    end
  end

  def destroy
    @circle.destroy
    redirect_to circles_path, notice: 'サークルを削除しました'
  end

  private
    def circle_params
      params.require(:circle).permit(:name, :description)
    end

    def set_circle
      @circle = Circle.find(params[:id])
      authorize @circle
    end
end
