Rails.application.routes.draw do
  # 超回復済みメニューの表示
  get '/menu_of_recovered_parts' => "menu_of_recovered_parts#show"
  patch '/menu_of_recovered_parts' => "menu_of_recovered_parts#create"

  devise_for :users

  root 'static_pages#home'
  get '/about' => "static_pages#about"

  get '/types_list' => "types#index"

  resources :menus, only: [:new, :create]
  resources :types, only: [:index, :new, :create]
  resources :users, only: [:show, :update]
  resources :indiv_part_menu, only: [:new, :create]
end
