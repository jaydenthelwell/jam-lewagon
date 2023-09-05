Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "pages#home"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: { registrations: "registrations" }

  # Defines the root path route ("/")
  # root "articles#index"

  resources :profiles, only: [:show, :edit, :update]

  get "profile", to: "users#profile"

  resources :users, only: [:index] do
    member do
      post :like
      post :dislike
    end
  end

  resources :users, except: [:index] do
    resources :socials, only: [:index, :show, :create]
  end

  # resources :matches, only: [:index]

  resources :chatrooms, only: [:index, :show] do

  resources :messages, only: :create


  end

  resources :top_genres, only: [:new, :create]

  delete '/genres/destroy_all', to: 'top_genres#destroy_all'
end
