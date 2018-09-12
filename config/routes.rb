Rails.application.routes.draw do

  resources :data, only: :index
  resources :characters, only: [:create, :update]
  resources :equipment, only: :index
  resources :features, only: :index
  resources :jobs, only: [:index, :show]
  resources :languages, only: :index
  resources :proficiencies, only: :index
  resources :races, only: [:index, :show]
  resources :sessions, only: [:create, :index]
  resources :skills, only: :index
  resources :spells, only: :index
  resources :subraces, only: :index

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
