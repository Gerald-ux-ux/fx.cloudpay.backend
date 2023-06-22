Rails.application.routes.draw do
  resources :openings
  resources :rates
  resources :collections, only: [:index, :show, :create]
  resources :users, only: [:index, :show, :create]
  resources :balances, only: [:show, :index, :create]
  resource :rates, only: [:show, :index, :create]
  resource :openings, only: [:show, :index, :create]
end
