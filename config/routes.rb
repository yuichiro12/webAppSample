Rails.application.routes.draw do
  root "users#home"
  
  get "/signup", to: "users#new"

  get "/login", to: "sessions#login"

  get "/logout", to: "sessions#logout"

  resources :users
end
