class CirclePolicy < ApplicationPolicy
	def index?
		user_logged_in?
	end

	def show?
		record.memberships.map{ |membership| membership.user }.include?(user)
	end

	def new?
		user_logged_in?
	end

	def create?
		user_logged_in?
	end

	def edit?
		is_owner?
	end

	def update?
		is_owner?
	end

	def destroy?
		is_owner? && record.members == [user]
	end

	private
		def is_owner?
			record.memberships.owner.map{ |membership| membership.user }.include?(user)
		end
end