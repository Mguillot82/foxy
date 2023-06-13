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
    # resources :friendships, only: %i[index create]
  end

  resources :collections, only: %i[destroy] do
    # resources :collections_catches, only: %i[create]
  end

  resources :animals, only: %i[show index new create]

  resources :catches, only: %i[create] do
    resources :animals, only: %i[show], controller: 'catches/animals'
  end

  # resources :collections_catches, only: %i[destroy]

  # resources :friendships, only: %i[destroy]

  resources :taxonomies, only: %i[create]

  # resources :got_badges, only: %i[create]

  resources :friends, only: %i[index show] do
    collection do
      get 'friends_requests'
    end
  end
end
