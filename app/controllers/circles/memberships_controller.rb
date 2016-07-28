class Circles::MembershipsController < ApplicationController
  before_action :set_circle

  def index
    @memberships = @circle.memberships
  end


  def create
  	# session[:user_id]を取得
  	@membership = @circle.memberships.build(role: :pending, user_id: session[:user_id])
  	if @membership.save
      MembershipMailer.new_member(@circle).deliver_now
  		redirect_to circles_path(@circle), notice: '管理者に申請を送りました'
  	else
  		flash.now.alert = '申請を送れませんでした'
  		render :new
  	end
  end

  private
    def set_circle
      @circle = Circle.find(params[:circle_id])
    end
end
