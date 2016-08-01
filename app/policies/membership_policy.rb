# ApplicationPolicyを継承
class MembershipPolicy < ApplicationPolicy
	def index?
		user_logged_in?
	end

	def create?
		user_logged_in? && !record.circle.memberships.map{ |membership| membership.user }.include?(user)
	end

	def update?
		is_owner?
	end

	def destroy?
		is_owner?
	end

	private
		def is_owner?
			record.circle.memberships.owner.map{ |membership| membership.user }.include?(user)
		end
end