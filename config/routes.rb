Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html  
  root to: "pages#home"

  devise_for :users


  # Defines the root path route ("/")
  # root "articles#index"
  get "profiles/:id", to: "profiles#show"
  resources :users, only: [:index] do
    member do
      post :like
      post :dislike
    end
  end

  resources :users, except: [:index]

  resources :matches, only: [:index] do
    resources :chatrooms, only: :show do
      resources :messages, only: :create
    end
  end

  resources :top_genres, only: [:new, :create]
end
