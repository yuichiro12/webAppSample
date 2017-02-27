Rails.application.routes.draw do
  root "users#home"
  
  get "/signup", to: "users#new"

  get "/login", to: "sessions#login"

  get "/logout", to: "sessions#logout"

  post "/create_skill", to: "users#create_skill"

  resources :users
  resources :user_skills, only: [:create, :destroy]
end
