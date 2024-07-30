Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  root "welcome#index"
  get "/search", to: "search#index", as: :search


  get "/auth/:provider/callback" => "sessions#create"
  get "/signout" => "sessions#destroy"
  
  resources :reality_check, only: [:index]
  resources :listings, only: [:show] do
    post 'reality_check', on: :member
  end


  get 'geocoder/city_from_location'

  mount RailsPerformance::Engine, at: 'rails/performance'
end
