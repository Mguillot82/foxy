Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'style', to: 'pages#style'
  get 'settings', to: 'pages#settings'
  get 'about', to: 'pages#about'

  resources :users, only: [:show] do
    resources :collections, except: %i[new destroy] do
      collection do
        get 'general'
      end
    end
    # resources :friendships, only: %i[index create]
  end

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
    resources :animals, only: [:show], controller: 'catches/animals'
  end

  resources :taxonomies, only: [:create]

  resources :friends, only: [:index, :show]
end
