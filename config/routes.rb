OpenMarket::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  #
  # Static pages
  #
  get "static_pages/home"
  get "static_pages/help"
  get "static_pages/about"

  #
  # Items reside within Shops
  #
  resources :shops do
    resources :items
  end
  resources :sessions, :users

  #
  # Root
  #
  root :to => 'static_pages#home'

  #
  # Generic paths
  #
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/signup',  to: 'users#new'
  match '/login',   to: 'sessions#new'
  match '/logout',  to: 'sessions#destroy'

  #
  # Singular user paths - for authenticated user access
  #
  scope '/:username', :constraints => ProfileConstraint do
    get '' => 'users#show'
  end
  scope '/:username/shops', :constraints => ProfileConstraint do
    get '' => 'shops#my_index'
  end
end
