Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  # ERRORS
  match "/404", to: "errors#not_found", via: :all
  match "/422", to: "errors#unacceptable", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  # Defines the root path route ("/")
  root "static_pages#home"
  get '/about', to: 'static_pages#about'
  
  # PWA service_worker
  get "/service-worker.js" => "service_worker#service_worker"
  get "/manifest.json" => "service_worker#manifest"
  get "/offline" => "service_worker#offline"
  
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }
  
  resources :dive_sites, only: [:index, :show, :edit, :update]
  resources :dive_centers, only: [:index, :show, :edit, :update]
  resources :geo_groups, only: [:index, :show, :edit, :update]
  resources :countries, only: [:index, :show, :edit, :update]

  get ':country/:region', to: 'regions#show', as: 'region'
  get ':country/:region/:city', to: 'cities#show', as: 'city'
  
  resources :regions, only: [:edit, :update]
  resources :cities, only: [:edit, :update]

#  resources :destinations, only: [:index] do
#    get ':country', to: 'destinations#country', on: :collection, as: 'country'
#    get ':country/:region', to: 'destinations#region', on: :collection, as: 'region'
#    get ':country/:region/:city', to: 'destinations#city', on: :collection, as: 'city'
#  end
  
  
end
