Rails.application.routes.draw do
  devise_for :users, controllers: { 
    confirmations: 'users/confirmations', 
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :users, only: [:show, :index, :destroy] do
    member do
      patch :ban
    end
  end
  root 'home#index'
end
