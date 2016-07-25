class Circles::MembershipsController < ApplicationController
  def create
  	@circle = Circle.find(params[:circle_id])
  	@membership = @circle.memberships.build(user_id: session[:user_id])
  	if @membership.save
  		redirect_to circle_path(@circle), notice: '参加しました'
  	else
  		flash.now.alert = '参加できませんでした'
  		render :new
  	end
  end
end
