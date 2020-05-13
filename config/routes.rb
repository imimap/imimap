# frozen_string_literal: true

Rails.application.routes.draw do
  get 'password_resets/new'
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users,
               controllers: {
                 registrations: 'users/registrations',
                 # registrations: 'devise/registrations'
                 passwords: 'users/passwords'
               }.merge(ActiveAdmin::Devise.config)
    devise_scope :user do
      get 'logout', to: 'devise/sessions#destroy', as: 'logout'
    end
    authenticated :user do
      root 'maps#map_view', as: :authenticated_root
    end
    root 'welcome#login'
    resources :internships
    resources :companies
    resources :users, only: %i[edit show update create new]
    resources :internship_offers, only: %i[index show new create]
    resources :notifications, only: %i[destroy show]
    resources :favorite, only: %i[create destroy index]
    resources :company_addresses
    resources :students, only: %i[show update]
    resources :complete_internships
    resources :user_can_see_companies
    resources :searches
    resources :postponements # , only: [:index, :new, :create, :approve, :show]
    get '/postponements/:id/approve',
        to: 'postponements#approve',
        as: 'approve_postponement'

    get 'statistic', to: 'statistic#overview'
    delete 'destroy', to: 'devise/notifications#destroy'

    get 'rating', to: 'internships#rating', as: 'rating'
    get 'newAddress/:company_id',
        to: 'company_addresses#new_address',
        as: 'new_address'
    post 'newAddress/:company_id',
         to: 'company_addresses#create_and_save',
         as: 'create_and_save'
    get 'select_company/',
        to: 'companies#select_company',
        as: 'select_company'
    get 'help', to: 'welcome#help'
    # get 'my_internship',
    #     to: 'complete_internships#show_own',
    #     as: 'my_internship'
    get 'no_complete_internship',
        to: 'complete_internships#no',
        as: 'no_complete_internship'
    post 'my_internship', to: 'company_addresses#create_and_save'
    post 'select_company/', to: 'companies#suggest'
    get 'suggest_address/', to: 'company_addresses#suggest_address'
    patch 'show/', to: 'company_addresses#save_address'
    get 'search',
        to: 'searches#start_search',
        as: 'start_search'
    post 'search_results',
         to: 'searches#show_results',
         as: 'show_results'
    get 'search_results', to: 'searches#show_results'
    post 'confirm_results', to: 'searches#confirm_results'
    delete 'reset_company_search_limit',
           to: 'user_can_see_companies#reset_limit_search'
    delete 'reset_company_suggest_limit',
           to: 'user_can_see_companies#reset_limit_suggest'
    delete 'reset_internship_search_limit',
           to: 'user_can_see_internships#reset_limit'
    ActiveAdmin.routes(self)
  end
end
