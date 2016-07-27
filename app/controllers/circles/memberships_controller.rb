class Circles::MembershipsController < ApplicationController
  def index
    @user = User.new
    circle_cricle_id
    @memberships = @circle.memberships
  end


  def create
  	circle_cricle_id

  	# session[:user_id]を取得
  	@membership = @circle.memberships.build(role: :pending, user_id: session[:user_id])
    session_user
  	if @membership.save
      MembershipMailer.new_member(@circle).deliver_now
  		redirect_to circles_path(@circle), notice: '管理者に申請を送りました'
  	else
  		flash.now.alert = '申請を送れませんでした'
  		render :new
  	end
  end

  private
    def circle_cricle_id
      @circle = Circle.find(params[:circle_id])
    end
end
