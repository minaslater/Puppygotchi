Rails.application.routes.draw do
  get 'users/new'

  root to: "puppies#index"
  resources :puppies
end
