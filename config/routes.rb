Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get 'search', to:"home#search"
  resources :warehouses, only: %i[show new create edit update destroy] do
    post 'product_entry', on: :member
  end
  resources :suppliers, only: [:index,:show, :new, :create, :edit, :update, :destroy]
  resources :product_models, only: [:index, :create, :new, :show, :edit, :update, :destroy] do
    patch :out, :in, on: :member 
  end

  resources :product_bundles, only: [:new, :create, :show]
  resources :categories, only: [:index,:new, :create, :show, :destroy]
  get 'product_items/entry', to: 'product_items#new_entry'
  post 'product_items/entry', to: 'product_items#process_entry'

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :warehouses, only: [:index, :show, :create]
      resources :suppliers, only: [:index, :show, :create]
      resources :product_models, only: [:index, :show, :create]
    end
  end
end
