Rails.application.routes.draw do

  resources :jobs, only: [:index, :show]
  resources :races, only: [:index, :show]
  resources :spells, only: :index
  resources :sessions, only: :create
  resources :characters, only: :create
  resources :subraces, only: :index

  get '/starting_equipment', to: 'starting_equipment#show'

  resources :test_users, only: :show do
    resources :characters, only: :index
  end
end
