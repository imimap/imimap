class InternshipOfferMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.internship_offer_mailer.new_internship_offer.subject
  #
  def new_internship_offer(offer)
    @offer = offer
    @title = @offer.title

    mail to: "asra.avisena@gmail.com",
    subject: "New internship offer added"
    # mail to: User.student_user.pluck(:email),
    #      subject: "New internship offer added"
  end
end
