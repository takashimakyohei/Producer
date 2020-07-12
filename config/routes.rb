Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :producers
  devise_for :users
  resources :products do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  resources :producers, only: [:index, :show, :edit, :update]
  resources :users, only: [:show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
