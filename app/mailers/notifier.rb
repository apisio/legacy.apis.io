class Notifier < ActionMailer::Base
  def contact(toemail, fromemail, message)
    
    mail( :to => toemail,
          :from => fromemail,
          :subject => "Message from APIs.io",
          :body => message)
             
  end
  
end
