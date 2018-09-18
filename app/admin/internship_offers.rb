# frozen_string_literal: true

ActiveAdmin.register InternshipOffer do
  permit_params InternshipOffersController.permitted_params

  form do |f|
    f.semantic_errors # shows errors on :base

    #  f.inputs          # builds an input field for every attribute,
    # see doc in formtastic
    # the input method is implemented by formtastic:
    # https://www.rubydoc.info/gems/formtastic/3.1.4#Documentation___Support
    # order was not nice, thus each attribute by it's own:
    
    f.input :title
    f.input :body
    f.input :orientation
    f.input :city
    f.input :country
    f.input :pdf

    f.actions # adds the 'Submit' and 'Cancel' buttons
  end
end
