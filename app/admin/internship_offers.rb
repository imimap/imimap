# frozen_string_literal: true

ActiveAdmin.register InternshipOffer do
  permit_params InternshipOffersController.permitted_params

  form do |f|
  f.semantic_errors # shows errors on :base
  f.inputs          # builds an input field for every attribute
  #f.actions         # adds the 'Submit' and 'Cancel' buttons
end
end
