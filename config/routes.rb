Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'style', to: 'pages#style'
  get 'settings', to: 'pages#settings'
  get 'about', to: 'pages#about'

  resources :users, only: %i[show] do
    resources :collections, except: %i[new] do
      collection do
        get 'general'
      end
    end
  end
  resources :friendships, only: %i[create]

  resources :collections, only: [:destroy] do
    member do
      post 'add_catch'
    end
    member do
      delete 'remove_catch'
    end
  end

  resources :animals, only: %i[show index new create] do
    collection do
      post 'get_loc_desc'
    end
  end

  resources :catches, only: %i[create] do
    resources :animals, only: %i[show], controller: 'catches/animals'
  end

  resources :taxonomies, only: %i[create]

  resources :friends, only: %i[index show edit new create] do
    collection do
      get 'friends_requests'
      post 'invite'
    end
    member do
      patch 'reject'
      patch 'add'
    end
  end
end
