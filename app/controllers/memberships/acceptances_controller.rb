class Memberships::AcceptancesController < ApplicationController
  def create
  	@circle = Circle.find(params[:circle_id])
  	
  end
end
