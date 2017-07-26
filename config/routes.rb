ImiMaps::Application.routes.draw do

  get "password_resets/new"

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do


    devise_scope :user do

      devise_for :users

      root to: 'startpage#new'

      authenticated :user do
        root 'overview#index', as: :authenticated_root
      end
      # match '/startpage/new', to: 'devise/sessions#create', as: "user" via: :post


    resources :internships

    resources :internship_statistic, :only  => [:index, :create]

    resources :companies

    resources :users, :only => [:edit, :show, :update, :create, :new]

    resources :user_verifications, only: [:new, :create]

    resources :overview, :only => [:index]

    resources :internship_offer, :only => [:index, :show]

    resources :notifications, :only => [:destroy, :show]

    resources :favorite, :only => [:create, :destroy, :index]

    # resources :location, :only => [:create, :destroy]

    # resources :sessions, :only => [:destroy, :create, :new]
      resources :startpage, :only  => [:create]

    resources :user_comments, :only => [:destroy, :update, :create, :new]

    resources :answers, :only => [:create, :update, :destroy]

    resources :general

    resources :internship_searches

    resources :quicksearches, :only => [:index]

    resources :favorite_compare, :only => [:index]

    resources :password_resets, :only => [:edit, :update, :create, :new]

    resources :errors, :only => [:not_found]


    # get 'signup', to: 'users#new', as: 'signup'
    get 'login', to: 'devise/sessions#create', as: 'login'
    get 'logout', to: 'devise/sessions#destroy', as: 'logout'

    match "/404", :to => "errors#not_found", :via => :all
    # erros in production are shadowed by this action looking for its non-existent template
   #  match "/500", :to => "errors#internal_server_error", :via => :all

    end
  end

  #root to: 'sessions#new'

  ActiveAdmin.routes(self)


  #match '*path', to: redirect {|params, request| "/#{I18n.default_locale}/#{CGI::unescape(params[:path])}" }
	#match '', to: redirect("/#{I18n.default_locale}/") , constraints: lambda { |req| !req.path.starts_with? "/#{I18n.default_locale}/" }


  #match 'de', to: redirect("/de/sessions#new")
  #match 'en', to: redirect("/en/sessions#new")
  #match 'id', to: redirect("/id/sessions#new")

  #match "*path", to: "errors#not_found"
end
