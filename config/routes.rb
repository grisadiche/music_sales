Rails.application.routes.draw do
  get '/', to: 'welcome#welcome'
  post '/api_button', to: 'users#api_button', as: 'api_button'

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
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :items, only: [:show, :index]
      resources :user_items
    end
  end
end
