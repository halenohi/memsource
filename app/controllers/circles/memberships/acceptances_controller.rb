class Circles::Memberships::AcceptancesController < ApplicationController
  def create
  	@circle = Circle.find(params[:circle_id])
  	@membership = @circle.memberships.find(params[:membership_id])
  	@membership.member!
  	redirect_to circle_memberships_path(@circle), notice: '承認しました'
  end
end
