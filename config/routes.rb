Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resources :orders, only: [:index, :show]
  controller :users do
    get 'user' => :index
    get 'user/edit' => :edit
    patch 'user' => :update
    delete 'user' => :destroy
    get 'edit_location'
    patch 'edit_location' => :set_location
  end
  controller :session do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :orders
      controller :users do
        post 'check_user' => :check_if_exists
      end
    end
  end
  root 'dashboard#index', as: 'index'
end
