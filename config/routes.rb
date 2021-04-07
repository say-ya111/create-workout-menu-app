Rails.application.routes.draw do
  get '/menu_of_recovered_parts' => "menu_of_recovered_parts#show"
  patch '/menu_of_recovered_parts' => "menu_of_recovered_parts#create"

  devise_for :users
  root 'static_pages#home'
  get '/about' => "static_pages#about"

  get '/types_list' => "types#index"
  get '/create_menu' => "menus#new"
  post '/create_menu' => "menus#create"

  resources :users, only: [:show, :update]
  resources :types, only: [:new, :create]
  resources :indiv_part_menu, only: [:new, :create]
end
