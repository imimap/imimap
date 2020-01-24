class InternshipOffersMailbox < ApplicationMailbox
  # before_processing :ensure_user
  # def process
  #   return if user.nil?
    
  #   user.internship_offers.create title:mail.subject, body: mail.decoded
  # end


  # def user 
  #   @user || = User.find_by(email: mail.from)
  # end

  # def ensure_user
  #   if user.nil?
  #     bounce_with UserMailer.missing(inbound_email)
  #   end
  # end
  
end
