Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"
  
  root to: "pages#home"

  devise_for :users

  resources :users, only: [:index] do
    member do
      post :swipe
      post :unswipe
    end
  end
  
  resources :users, except: [:index]
end
