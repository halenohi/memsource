class ApplicationPolicy
	attr_reader :user, :record

	def initialize(user, record)
		@user = user
		@record = record
	end

	private
		def user_logged_in?
			user != nil
		end
end