Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'style', to: 'pages#style'
  get 'settings', to: 'pages#settings'
  get 'about',  to: 'pages#about'

  resources :users, only: [:show] do
    resources :collections, except: %i[new] do
      collection do
        get 'general'
      end
    end
    resources :friendships, only: %i[index create]
  end

  resources :collections, only: [:destroy] do
    resources :collections_catches, only: %i[create]
  end

  resources :animals, only: %i[show index create]

  resources :catches, only: %i[create] do
    resources :animals, only: [:show], controller: 'catches/animals'
  end

  resources :collections_catches, only: [:destroy]

  resources :friendships, only: [:destroy]

  resources :taxonomies, only: [:create]

  resources :got_badges, only: [:create]
  
  resources :friends, only: [:index, :show]

end
