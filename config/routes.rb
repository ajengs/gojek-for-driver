Rails.application.routes.draw do
  resources :users do
    member do
      get 'edit_location'
      patch 'edit_location' => :set_location
    end
  end

  controller :session do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  root 'dashboard#index', as: 'index'
end
