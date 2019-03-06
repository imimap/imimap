# frozen_string_literal: true

Rails.application.routes.draw do
  get 'password_resets/new'
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    devise_scope :user do
      devise_for :users,
                 controllers: { registrations: 'users/registrations',
                                passwords: 'users/passwords' }
      # This is needed for ActiveAdmin
      authenticated :user do
        root 'maps#map_view', as: :authenticated_root
      end
      root 'maps#peek_preview'

      resources :internships
      resources :companies
      resources :users, only: %i[edit show update create new]
      resources :internship_offers, only: %i[index show new create]
      resources :notifications, only: %i[destroy show]
      resources :favorite, only: %i[create destroy index]
      resources :company_addresses
      resources :students, only: %i[show update]
      resources :complete_internships

      get 'login', to: 'devise/sessions#create', as: 'login'
      get 'logout', to: 'devise/sessions#destroy', as: 'logout'
      get 'statistic', to: 'statistic#overview'
      delete 'destroy', to: 'devise/notifications#destroy'
      get 'rating', to: 'internships#rating', as: 'rating'
      get 'newAddress/:company_id',
          to: 'company_addresses#new_address',
          as: 'new_address'
      get 'select_company/',
          to: 'companies#select_company',
          as: 'select_company'
      get 'help', to: 'welcome#help'
    end
    ActiveAdmin.routes(self)
  end
  # TBD Review: what is this special route for outside of the other scopes?
  get 'my_internship', to: 'complete_internships#internship_data', as: 'my_internship'
end
