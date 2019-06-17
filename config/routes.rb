require 'api_constraints.rb'

Rails.application.routes.draw do
  get '/', to: 'welcome#welcome'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :items

  resources :users do
    collection do
      get "profile"
    end
  end

  namespace :api, defaults: { format: :json } do
    scope module: :v1, constraints: ApiConstraints.new(version: 1) do
      resources :items
    end
    scope module: :v2, constraints: ApiConstraints.new(version: 2, default: true) do
      resources :items
    end
  end
end
