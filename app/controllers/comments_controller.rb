class CommentsController < ApplicationController
  def destroy
  	@comment = Comment.find(params[:id])
  	@comment.destroy
  	redirect_to circles_path(@circle), alert: 'コメントを消去しました'
  end
end
