Rails.application.routes.draw do
  get 'producers/index'
  get 'producers/show'
  get 'producers/edit'
  root to: 'home#index'
  resources :products
  resources :producers, only: [:index, :show, :edit, :update]
  devise_for :producers
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
