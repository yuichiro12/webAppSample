# coding: utf-8
Rails.application.routes.draw do
  root "users#home"
  
  get "/signup", to: "users#new"

  get "/login", to: "sessions#new"

  post "/login", to: "sessions#create"

  delete "/logout", to: "sessions#destroy"

  post "/add_skill", to: "users#create_skill"

  post "/add_plus_one", to: "users#create_plus_one"

  resources :users
  # TODO 使わないかも
  resources :user_skills, only: [:create, :destroy]
end
