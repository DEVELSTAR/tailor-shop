Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :reviews, only: [:index]
      resource :business_info, only: [:show], controller: :business_infos
    end
  end
  
  root "home#index"

  resources :reviews, only: [:index, :new, :create]
  resources :bookings, only: [:new, :create]
  resources :galleries, only: [:index, :show]
  
  # Add routes for sitemap generation
  resources :categories, only: [:show]
  resources :products, only: [:show]

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  namespace :admin do
    root "dashboard#index"
    resources :business_infos, only: [:edit, :update]
    resources :reviews, only: [:index, :update, :destroy]
    resources :categories do
      resources :products, only: [:index, :new, :create]
    end
    resources :products, except: [:index, :new, :create]
    resources :customers
    resources :bookings
    resources :galleries
    
    # Catch-all route for security - handle suspicious requests
    match '*path', to: redirect('/admin'), via: :all
  end
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/") 
  # root "posts#index"
end
