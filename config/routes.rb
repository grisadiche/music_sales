# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'users/create'
  # get 'users/new'
  # get 'users_controller/new'
  # get 'users_controller/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#welcome'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :items

  resources :users do
    collection do
      get 'profile'
    end
  end
end
