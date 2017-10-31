ImiMaps::Application.routes.draw do
  get "password_resets/new"
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_scope :user do
      devise_for :users
      root to: 'startpage#new'
      authenticated :user do
        root 'overview#index', as: :authenticated_root
      end
      resources :internships
      resources :companies
      resources :users, only: %i[edit show update create new]
      resources :user_verifications, only: %i[new create]
      resources :overview, only: %i[index]
      resources :internship_offer, only: %i[index show]
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
      resources :errors, only: %i[not_found]
      get 'login', to: 'devise/sessions#create', as: 'login'
      get 'logout', to: 'devise/sessions#destroy', as: 'logout'
      get 'statistic', to: 'statistic#overview'
      get 'debug', to: 'overview#debug', as: 'debug'
      match '/404', to: 'errors#not_found', via: :all
      # erros in production are shadowed by this action looking for its
      # non-existent template
      # match "/500", :to => "errors#internal_server_error", :via => :all
    end
    ActiveAdmin.routes(self)
  end
  # TBD Review: what is this special route for outside of the other scopes?
  get 'my_internship', to: 'internships#internshipData', as: 'my_internship'
end
