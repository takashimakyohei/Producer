Rails.application.routes.draw do
  get 'rooms/show'
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
  resources :rooms, only: [:show, :create] do
    resources :messages, only: [:create]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
