Rails.application.routes.draw do
  root to: "puppies#index"
  resources :users
  resources :puppies
  resources :sessions, only: [:new, :create, :destroy]
end
