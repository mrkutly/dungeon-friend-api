Rails.application.routes.draw do

  resources :jobs, only: [:index, :show]
  resources :races, only: [:index, :show]
  resources :spells, only: :index
  resources :sessions, only: :create
  resources :characters, only: [:create, :update]
  resources :subraces, only: :index
  resources :equipment, only: :index
  resources :skills, only: :index
  resources :proficiencies, only: :index

  get '/starting_equipment', to: 'starting_equipment#show'
  get '/packs', to: 'packs#show'

  resources :test_users, only: :show do
    resources :characters, only: :index
  end

  resources :users, only: :create
  
  resources :users, only: :show do
    resources :characters, only: :index
  end

  mount ActionCable.server, at: '/cable'
end
