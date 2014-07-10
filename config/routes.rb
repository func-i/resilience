Rails.application.routes.draw do
  devise_for :users

  # resources :home, only: [:index]

  resources :user_profiles, only: [:edit, :update]

  root to: 'home#index'
end
