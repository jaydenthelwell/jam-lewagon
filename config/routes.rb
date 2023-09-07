Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "pages#home"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: { registrations: "registrations" }

  # Defines the root path route ("/")
  # root "articles#index"

  resources :profiles, only: [:show, :edit, :update]

  get "profile", to: "users#profile", as: :user_profile

  resources :users, only: [:index, :update] do
    member do
      post :like
      post :dislike
    end
  end

  resources :users, except: [:index] do
    resources :socials, only: [:show, :create, :new]
  end

  resources :socials, only: [:index, :destroy]

  # resources :matches, only: [:index]

  resources :chatrooms, only: [:index, :show] do
    resources :messages, only: :create
  end

  resources :top_genres, only: [:new, :create]
  resources :top_tracks, only: [:new, :create]

  get "/top_genres/spotify", to: "top_genres#spotify"
  get "/top_tracks/spotify", to: "top_tracks#spotify"

  delete '/genres/destroy_all', to: 'top_genres#destroy_all'
  get "/user/chatrooms", to: "chatrooms#user_chatrooms"


  delete '/tracks/destroy_all', to: 'top_tracks#destroy_all'

end
