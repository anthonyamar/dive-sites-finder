Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "static_pages#home"
  
  # PWA service_worker
  get "/service-worker.js" => "service_worker#service_worker"
  get "/manifest.json" => "service_worker#manifest"
  get "/offline" => "service_worker#offline"
  
  resources :dive_sites, only: [:index, :show]
  resources :dive_centers, only: [:index, :show]
  resources :geo_groups, only: [:index, :show]
  resources :destinations, only: [:index] do
    get ':country', to: 'destinations#country', on: :collection, as: 'country'
    get ':country/:region', to: 'destinations#region', on: :collection, as: 'region'
    get ':country/:region/:city', to: 'destinations#city', on: :collection, as: 'city'
  end

  
end
