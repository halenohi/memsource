class CirclesController < ApplicationController
  def index
    @circles = Circle.all.order(updated_at: :desc)
  end

  def show
    # @circleからid取得
    @circle = Circle.find(params[:id])
  end

  def new
    @circle = Circle.new
  end

  def create
    @circle = Circle.new(circle_params)
    
    # saveでdbに保存
    if @circle.save
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
    @circle.destroy
    redirect_to circles_path, notice: '消去しました'
  end

  private
    def circle_params
      params.require(:circle).permit(:name, :description)
    end
end
