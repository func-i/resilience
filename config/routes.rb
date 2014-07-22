Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      registrations: 'users/registrations'
    }

  # resources :home, only: [:index]

  resources :user_profiles, only: [:edit, :update]
  resources :registration_invitations, only: [:new, :create]

  namespace :manage  do
    resources :users, except: [:new]
  end

  root to: 'home#index'
end
