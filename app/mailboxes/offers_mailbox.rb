class OffersMailbox < ApplicationMailbox
  # MATCHER = /testing@htw-berlin.de/i

  def process
    # return if user.nil?

    InternshipOffer.create(title:mail.subject, body: mail.decoded)
    
    # internship_offers.create(
    #   title:mail.subject, body: mail.decoded
    # )
  end

  # def user 
  #   @user || = User.find_by(email: mail.from)
  # end

  # def internship_offers
  #   @internshipoffers || = InternshipOffer.find(offer_id)
  # end

  # def offer_id
  #   recipient = mail.recipient.find {|r| MATCHER.match?(r)}
  #   recipient[MATCHER, 1]
  # end

  # def ensure_user
  #   if user.nil?
  #     bounce_with UserMailer.missing(inbound_email)
  #   end
  # end
  
end
