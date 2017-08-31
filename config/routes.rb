Rails.application.routes.draw do
  root to: "puppies#index"
  resources :users
  resources :puppies
end
