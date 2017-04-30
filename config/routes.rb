Rails.application.routes.draw do
  root to: "puppies#index"
  resources :puppies
end
