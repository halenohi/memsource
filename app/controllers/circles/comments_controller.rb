class Circles::CommentsController < ApplicationController
  def new
  	# circle_idを引き継ぎさせる
  	@circle = Circle.find(params[:circle_id])

  	# @circleとcommentsを組み立てる(build)
  	@comment = @circle.comments.build
  end

  def create
  	@circle = Circle.find(params[:circle_id])

  	# buildとnewは同じ働きをする
  	@comment = @circle.comments.build(comment_params)
  	if @comment.save
  		redirect_to circle_path(@circle), notice: 'コメント作成しました'
  	else
  		flash.now.alert = 'コメント作成に失敗しました'
  		render :new
  	end
  end

  def edit
    # 親をfind
  	@circle = Circle.find(params[:circle_id])

    # 子をfind
    @comment = @circle.comments.find(params[:id])
  end

  def update
  	@circle = Circle.find(params[:circle_id])
    @comment = @circle.comments.find(params[:id])

  	if @comment.update(comment_params)
      # circleのshowに飛ばす
  		redirect_to @circle
  	else
  		render 'edit'
  	end
  end

  private
  	def comment_params
  		params.require(:comment).permit(:content).merge(user_id: session[:user_id])
  	end
end
