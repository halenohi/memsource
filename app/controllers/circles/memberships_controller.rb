class Circles::MembershipsController < ApplicationController
  def index
    @circle = Circle.find(params[:circle_id])
    @memberships = @circle.memberships
  end


  def create
  	@circle = Circle.find(params[:circle_id])

  	# session[:user_id]を取得
  	@membership = @circle.memberships.build(role: :pending, user_id: session[:user_id])
    @user = User.find(session[:user_id])
  	if @membership.save
      MembershipMailer.new_member(@circle).deliver_now
  		redirect_to circles_path(@circle), notice: '管理者に申請を送りました'
  	else
  		flash.now.alert = '申請を遅れませんでした'
  		render :new
  	end
  end
end
