Rails.application.routes.draw do
  
  resources :courses do
    resources :lessons, except: %i[index show], controller: "courses/lessons"
    member do
      patch :generate_lessons 
    end
  end
  resources :services
  resources :classrooms
  devise_for :users, controllers: { 
    confirmations: 'users/confirmations', 
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :users, only: [:show, :index, :destroy, :edit, :update] do
    member do
      patch :ban
      patch :resend_confirmation_instructions
      patch :resend_invitation
    end
  end
  root 'home#index'
end
