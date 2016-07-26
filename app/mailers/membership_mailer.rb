class MembershipMailer < ActionMailer::Base
  default from: 'from@example.com'
  
  def new_member(circle)
  	@circle = circle
  	@url = 'http://example.com/login'

  	# ownerのfirstのuserのemailアドレス指定
  	mail(to: @circle.memberships.owner.first.user.email, subject: 'Welcome to my awsome circle')
  end
end
