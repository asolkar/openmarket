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
  # Default routes
  #
  resources :items do
    resources :photos
  end
  resources :shops do
    resources :items do
      resources :photos
    end
  end
  resources :sessions

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

  match '/users/:username/edit', to: 'users#edit'
  match '/users/:username', to: 'users#update', :via => :put
  match '/users/:username', to: redirect { |params, req| "/#{params[:username]}" }

  #
  # Paths for user scoped access
  #
  scope '/:username', :constraints => ProfileConstraint do
    get '' => 'users#show'
    get 'edit' => 'users#edit'
    resources :shops do
      resources :items do
        resources :photos
      end
    end
  end
  resources :users
end
