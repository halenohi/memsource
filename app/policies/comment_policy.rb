class CommentPolicy < ApplicationPolicy
	def new?
		is_circle_member?
	end

	def create?
		is_circle_member?
	end

	def edit?
		is_own_comment?
	end

	def update?
		is_own_comment?
	end

	def destroy?
		is_own_comment? && is_circle_owner?
	end

	private
		def is_own_comment?
			record.user == user
		end

		def is_circle_owner?
			record.circle.memberships.owner.map{ |membership| membership.user }.include?(user)
		end

		def is_circle_member?
			user_logged_in? && record.circle.members.include?(user)
		end
end