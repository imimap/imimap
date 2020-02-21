# Preview all emails at http://localhost:3000/rails/mailers/internship_offer
class InternshipOfferPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/internship_offer/new_internship_offer
  def new_internship_offer
    offer = InternshipOffer.new(title: "testing", body:"testing action mailer", active: false)
    InternshipOfferMailer.new_internship_offer(offer)
  end

end
