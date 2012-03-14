class FollowMailer < ActionMailer::Base
  default from: "noreply@apis.io"
  # rails g mailer follow_mailer alerter

  def alerter(from, to, photo, email)
    @from = from
    @to = to
    @photo = photo
    mail to: email, subject: "New APIs.io Follower", :from => "noreply@APIs.io"
  end
end
