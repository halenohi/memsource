class Circles::Memberships::AcceptancesController < ApplicationController
  def create
  	@circle = Circle.find(params[:circle_id])
  	# policiesで対応ファイル指定
    authorize @circle

  	@membership = @circle.memberships.find(params[:membership_id])
  	# policiesで対応ファイル指定
    authorize @membership

  	@membership.member!
  	redirect_to circle_memberships_path(@circle), notice: '承認しました'
  end
end
