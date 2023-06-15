Rails.application.routes.draw do
  get 'profiles/index'
  get "home/about"
  get "posts/myposts"
  root "posts#index"


  resources :posts do
    resources :likes, only: [:index]
  end

  resources :comments
  resources :likes, only: [:create, :destroy]

  devise_scope :user do
    get "/users/sign_up", to: "devise/registrations#new"
    get "/users/sign_out", to: "devise/sessions#destroy"
  end
  devise_for :users, controllers: {
    registrations: "users/registrations",
  }
  resources :users

  post 'users/:id/follow', to: "users#follow", as: "follow"
  post 'users/:id/unfollow', to: "users#unfollow", as: "unfollow"
  post 'users/:id/accept', to: "users#accept", as: "accept"
  post 'users/:id/decline', to: "users#decline", as: "decline"
  post 'users/:id/cancel', to: "users#cancel", as: "cancel"
end
