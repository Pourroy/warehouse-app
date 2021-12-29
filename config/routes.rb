Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :warehouses, only: [:show, :new, :create,:edit, :update]
  resources :suppliers, only: [:index,:show, :new, :create, :edit, :update]
  resources :product_models, only: [:create, :new, :show, :edit, :update]
  resources :product_bundles, only: [:new, :create, :show]
  resources :categories, only: [:index,:new, :create, :show]
end
