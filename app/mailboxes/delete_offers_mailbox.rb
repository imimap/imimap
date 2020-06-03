# frozen_string_literal: true

class DeleteOffersMailbox < ApplicationMailbox
  before_processing :ensure_user
  def process
    return if user.nil?

    title_in_email = mail.subject
    @offer = InternshipOffer.destroy_by(title: title_in_email)
  end

  def user
    @user = User.find_by(email: mail.from, id: 2)
  end

  def ensure_user
    bounce_with UserMailer.missing(inbound_email) if user.nil?
  end
end
