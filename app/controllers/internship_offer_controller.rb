# frozen_string_literal: true

# Offers for Internship Positions
class InternshipOfferController < ApplicationController
  def index
    @offers = InternshipOffer.all
  end

	def show
		@offer = InternshipOffer.find(params[:id])
	end

	def edit
		@offer = InternshipOffer.find(params[:id])
	end

  def new
		@offer_new = InternshipOffer.new
	end

	def create
		@offer = InternshipOffer.new(internship_offer_params)

		respond_to do |format|
			if @offer.save
				format.html { redirect_to @offer }
				format.json { render json: @offer, status: :created, location: @offer }
			else
				format.html { render action: "new" }
				format.json { render json: @offer.errors, status: :unprocessable_entity }
			end
		end
	end

# TBD there is no update, but an edit.

  def internship_offer_params
    params.require(:internship_offer).permit(:title, :body, :pdf)
  end
end
