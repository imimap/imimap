# frozen_string_literal: true

class AddOffersMailbox < ApplicationMailbox
  before_processing :ensure_user
  def process
    return if user.nil?

    active_in_email = find_active(mail.subject)

    country_in_email = find_country(mail.subject)
                       .chomp('- ' + active_in_email)

    city_in_email = find_city(mail.subject).chomp
    (', ' + country_in_email + '- ' + active_in_email)

    title_in_email = mail.subject.chomp(' in ' +
    city_in_email + ', ' + country_in_email +
    '- ' + active_in_email)

    @offer = InternshipOffer.create(title: title_in_email,
                                    body: mail.decoded, city: city_in_email,
                                    country: country_in_email, active: active_in_email)
    # if @offer.active == true
    #   InternshipOfferMailer.new_internship_offer(@offer).deliver_now
    # end
  end

  def find_city(subject)
    city_email = subject.split(' in ').last
  end

  def find_country(subject)
    country_email = subject.split(', ').last
  end

  def find_active(subject)
    active_email = subject.split('- ').last
  end

  def user
    @user = User.find_by(email: mail.from, id: 2)
  end

  def ensure_user
    bounce_with UserMailer.missing(inbound_email) if user.nil?
  end
end
