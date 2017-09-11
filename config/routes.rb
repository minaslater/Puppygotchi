Rails.application.routes.draw do
  root to: "puppies#index"
  resources :users do
    resources :friendships
  end
  resources :puppies
  resources :sessions, only: [:new, :create, :destroy]
end
