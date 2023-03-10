Rails.application.routes.draw do

  resources :hotspots

  devise_for :users
  root to: "requests#new"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/favorites', to: 'users#favorites'
  # Defines the root path route ("/")
  # root "articles#index"

  resources :itineraries, only: %i[index new create show]

  resources :categories, only: %i[index show]

  resources :requests, only: %i[new show create]

  get '/users/:id', to: 'users#show', as: 'user'
end
