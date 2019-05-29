Rails.application.routes.draw do
  get 'users/create'
  get 'users/new'
  get 'users_controller/new'
  get 'users_controller/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :items
  resources :users
  #   resources :items, except: [:show, :destroy],
  # end
end
