# coding: utf-8
Rails.application.routes.draw do
  root "users#home"
  
  get "/signup", to: "users#new"

  get "/login", to: "sessions#new"

  post "/login", to: "sessions#create"

  delete "/logout", to: "sessions#destroy"

  post "/add_skill", to: "users#create_skill"

  post "/plus1", to: "users#plus1"

  resources :users
  # TODO 使わないかも
  resources :user_skills, only: [:create, :destroy]
end
