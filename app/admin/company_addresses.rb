# frozen_string_literal: true

ActiveAdmin.register CompanyAddress do
  menu priority: 5
  permit_params CompanyAddressesController.permitted_params
  filter :city
  filter :country
end
