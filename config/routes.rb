Rails.application.routes.draw do

  devise_for :users
  
  

  resources :users, only: [:show, :edit, :update, :index]
  resources :books

  root "homes#top"
  get "about" , to: "homes#about", as: "home_about"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
