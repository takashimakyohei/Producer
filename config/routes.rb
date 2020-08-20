Rails.application.routes.draw do

  root to: 'home#index'
  devise_for :producers
  devise_for :users
  resources :products do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  resources :comments, only: [:destroy]
  resources :producers, only: [:index, :show, :edit, :update]
  resources :users, only: [:show]
  resources :rooms, only: [:index,:show, :create] do
    resources :messages, only: [:create]
  end
  
  # 例外
  get '*path', to: 'application#routing_error', constraints: lambda{ |req|
    req.path.exclude? "rails/active_storage"
  }


end
