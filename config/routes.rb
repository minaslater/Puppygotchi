Rails.application.routes.draw do
  root to: "puppy#index"
  resources :puppy
end
