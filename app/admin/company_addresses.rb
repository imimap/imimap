# frozen_string_literal: true

ActiveAdmin.register CompanyAddress do
  menu parent: 'company', priority: 2
  permit_params CompanyAddressesController.permitted_params
  filter :city
  filter :country
end
