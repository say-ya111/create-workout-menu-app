Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'
  get '/about' => "static_pages#about"

  get '/types_list' => "types#index"
  get '/create_menu' => "menus#new"
  post '/create_menu' => "menus#create"

  resources :users, only: [:show]
end
