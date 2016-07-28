class Circles::CommentsController < ApplicationController
  before_action :set_circle
  before_action :set_comment, only: [:edit, :update]

  def new
  	# circle_idを引き継ぎさせる
  	# set_circle

  	# @circleとcommentsを組み立てる(build)
  	@comment = @circle.comments.build
    authorize @comment
  end

  def create
  	# set_circle

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
  	# set_circle

    # 子をfind
    # set_comment
  end

  def update
  	# set_circle
    # set_comment

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

    def set_circle
      @circle = Circle.find(params[:circle_id])
    end

    def set_comment
      @comment = @circle.comments.find(params[:id])
    end
end
