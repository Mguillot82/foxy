Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get '/style', to: 'pages#style'

  resources :users, only: [:show] do

    resources :collections, except: [:destroy] do
      collection do
        get 'general'
      end
    end
  end

  resources :collections, only: [:destroy]
end
