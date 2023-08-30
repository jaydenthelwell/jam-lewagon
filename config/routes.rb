Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

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
end
