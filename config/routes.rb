Rails.application.routes.draw do
  resources :collections, only: [:index, :show, :create]
  resources :users, only: [:index, :show, :create]
  resources :balances, only: [:show, :index, :create]
end
