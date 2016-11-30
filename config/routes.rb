Rails.application.routes.draw do
  resources :products
  get 'shopping_cart', to: 'shopping_carts#show', as: 'shopping_cart'
  post 'shopping_cart', to: 'shopping_carts#create'
  put 'shopping_cart', to: 'shopping_carts#update'
  patch 'shopping_cart', to: 'shopping_carts#update'

  root 'products#index'
end
