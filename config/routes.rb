Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'confirmations' }
  resources :users, only: [:show, :index, :destroy] do
    member do
      patch :ban
    end
  end
  root 'home#index'
end
