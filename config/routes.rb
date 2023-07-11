Rails.application.routes.draw do
  resources :collections, only: [:index, :show, :create]
  resources :users, only: [:index, :show, :create, :destroy] do
    delete '', action: :destroy, on: :collection
  end
  resources :balances, only: [:show, :index, :create]
  resources :rates, only: [:show, :index, :create, :destroy]
  resources :openings, only: [:show, :index, :create, :destroy]
  resources :disbursments, only: [:show, :index, :create, :destroy]
  resources :closings, only: [:show, :index, :create]

  post '/users/login', to: 'users#login' # Custom login route
end
