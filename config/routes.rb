Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "puppy#index"
  get "/puppies/new", to: "puppy#new"
  post "/puppies", to: "puppy#create"
  get "/puppies/:id", to: "puppy#show"

end
