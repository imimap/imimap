# frozen_string_literal: true

ActiveAdmin.register InternshipOffer do
  permit_params InternshipOffersController.permitted_params
end
