# frozen_string_literal: true

Rails.application.routes.draw do
  get 'password_resets/new'
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    devise_scope :user do
      devise_for :users, controllers: { registrations: 'users/registrations', passwords: 'users/passwords' }
      root to: 'startpage#new'
      # This is needed for ActiveAdmin
      authenticated :user do
        root 'overview#index', as: :authenticated_root
      end
      resources :internships
      # TBD ST resources :internships, only: %i[new edit show update create rating]
      resources :companies
      resources :users, only: %i[edit show update create new student_show]
      resources :user_verifications, only: %i[new create]
      resources :overview, only: %i[index]
      resources :internship_offer, only: %i[index show new create]
      resources :notifications, only: %i[destroy show]
      resources :favorite, only: %i[create destroy index]
      resources :current_internships, only: %i[index]
      resources :startpage, only: %i[create]
      resources :user_comments, only: %i[destroy update create new]
      resources :answers, only: %i[create update destroy]
      resources :general
      resources :internship_searches
      resources :quicksearches, only: %i[index]
      resources :favorite_compare, only: %i[index]
      resources :report_overview, only: [:index]
      resources :read_list, only: %i[create destroy index]
      resources :complete_report, only: [:index]
      resources :internship_status, only: [:index]
      resources :finish_list, only: %i[create destroy index]
      resources :company_addresses

      get 'login', to: 'devise/sessions#create', as: 'login'
      get 'logout', to: 'devise/sessions#destroy', as: 'logout'
      get 'statistic', to: 'statistic#overview'
      get 'debug', to: 'overview#debug', as: 'debug'
      delete 'destroy', to: 'devise/notifications#destroy'
      get 'student_show', to: 'users#student_show', as: 'student_show'
      get 'rating', to: 'internships#rating', as: 'rating'
      get 'newAddress/:company_id', to: 'company_addresses#new_address', as: 'new_address'
      get 'select_company/', to: 'companies#select_company', as: 'select_company'
    end
    ActiveAdmin.routes(self)
  end
  # TBD Review: what is this special route for outside of the other scopes?
  get 'my_internship', to: 'internships#internship_data', as: 'my_internship'
end
