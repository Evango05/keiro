Rails.application.routes.draw do

  resources :hotspots

  devise_for :users
  root to: "requests#new"

  get '/favorites', to: 'users#favorites'

  resources :itineraries, only: %i[index new create show]

  resources :itineraries, only: %i[show] do
    get "/navigation", to: "itineraries#navigation"
    get "/recap", to: "itineraries#recap"
  end

  resources :categories, only: %i[index show]

  resources :requests, only: %i[new show create]

  get '/users/:id', to: 'users#show', as: 'user'
end
