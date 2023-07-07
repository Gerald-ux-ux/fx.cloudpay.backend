Rails.application.routes.draw do
  resources :closings
  resources :disbursments
  resources :openings
  resources :rates
  resources :collections, only: [:index, :show, :create]
  resources :users, only: [:index, :show, :create]
  resources :balances, only: [:show, :index, :create]
  resource :rates, only: [:show, :index, :create, :destroy]
  resource :openings, only: [:show, :index, :create, :destroy]
   resource :disbursments, only: [:show, :index, :create, :destroy]

  post '/users/login', to: 'users#login' # Custom login route
end
