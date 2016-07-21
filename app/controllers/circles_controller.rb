class CirclesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @circle = Circle.new
  end

  def create
    @circle = Circle.new
    @circle.assign_attributes(credential_circle)
    if @circle.save
      redirect_to root_path
    else
      flash.now.alert = 'もう一度ご記入ください'
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
    circle.delete(:circle_id)
    render :new
  end

  private
    def credential_circle
      params.require(:circle).permit(:name, :description)
    end
end
