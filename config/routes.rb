Rails.application.routes.draw do

  get 'requests/new'
  get 'requests/create'

  resources :hotspots

  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/favorites', to: 'users#favorites'
  # Defines the root path route ("/")
  # root "articles#index"

  resources :itineraries, only: %i[index new create show]

  resources :categories, only: %i[index show]

  resources :requests, only: %i[new show create]
end
