Rails.application.routes.draw do
  resources :likes, only: [:create, :destroy]
  root 'home#index'
  devise_for :users
 resources :books
end
