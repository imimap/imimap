# frozen_string_literal: true

ActiveAdmin.register InternshipOffer do
  menu parent: 'imimap', priority: 8
  # permit_params InternshipOffersController.permitted_params
  permit_params :title, :body, :created_at, :updated_at, :city, :country, 
  :active, :user_id
   
  #  Action mailer send
   after_save do |internship|
    if internship.active == true
      InternshipOfferMailer.new_internship_offer(internship).deliver_now
    end
   end
end
