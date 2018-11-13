# frozen_string_literal: true

ActiveAdmin.register InternshipOffer do
  menu priority: 7
  permit_params InternshipOffersController.permitted_params
end
