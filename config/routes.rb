Rails.application.routes.draw do
  resources :hotspots
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/favorites', to: 'users#favorites'
  # Defines the root path route ("/")
  # root "articles#index"
end
