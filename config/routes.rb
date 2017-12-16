Rails.application.routes.draw do
  controller :users do
    get 'user' => :index
    get 'register' => :new
    post 'register' => :create
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

  root 'dashboard#index', as: 'index'
end
