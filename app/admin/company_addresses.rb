# frozen_string_literal: true

ActiveAdmin.register CompanyAddress do
  permit_params CompanyAddressesController.permitted_params
  filter :city
  filter :country
end
