Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'top#show'
  resources :users
  resources :recruits, except: [:edit] do
    resources :entries, only: [:new, :create, :show]
  end

end
