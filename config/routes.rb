Rails.application.routes.draw do

  resources :jobs, only: :index
  resources :races, only: :index
  resources :spells, only: :index
  resources :sessions, only: :create
end
