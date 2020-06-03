# frozen_string_literal: true

# :nocov:
# Offers for Internship Positions
class InternshipOffersController < ApplicationResourceController
  def index
    @offers = InternshipOffer.order('created_at DESC').where(active: true)
    @size = InternshipOffer.where('updated_at > ?', @current_user.last_sign_in_at).size
  end

  def show
    @user = current_user
    @current_user.update(last_sign_in_at: Time.zone.now)
    @offer = InternshipOffer.find(params[:id])
  end

  # TBD there is no update, but an edit.
  def edit
    @offer = InternshipOffer.find(params[:id])
  end

  def new
    @offer_new = InternshipOffer.new
  end

  def create
    @offer = InternshipOffer.new(internship_offer_params)
    @offer.user = current_user

    respond_to do |format|
      if @offer.save
        format.html { redirect_to @offer }

        # Action Mailer
        if @offer.active == true
          InternshipOfferMailer.new_internship_offer(@offer).deliver_now
        end
      #    format.json { render json: @offer,
      #      status: :created, location: @offer }
      else
        format.html { render action: 'new' }
        #    format.json { render json: @offer.errors,
        #      status: :unprocessable_entity }
      end
    end
  end

  def internship_offer_params
    params.require(:internship_offer).permit(:title, :body, :pdf, :city, :country,
                                             :active, :user_id)
    # params.require(:internship_offer).permit(permitted_params)
  end

  # def self.permitted_params
  #   %i[title body pdf city country active]
  # end
end
# :nocov:
