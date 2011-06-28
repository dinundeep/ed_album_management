class Emailer < ActionMailer::Base
  def contact(recipient, subject, message, sent_at = Time.now)
    @subject = subject
    @recipients = recipient
    @from = 'kplguru07@gmail.com'
    @sent_on = sent_at
    @body = message
    @headers = {}
  end
end
