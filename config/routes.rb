Rails.application.routes.draw do
  get "home/about"
  get "posts/myposts"
  root "posts#index"

  resources :posts
  resources :comments

  devise_scope :user do
    get "/users", to: "devise/registrations#new"
    get "/users/password", to: "devise/passwords#new"
    get "/users/sign_out", to: "devise/sessions#destroy"
  end
  devise_for :users, controllers: {
    registrations: "users/registrations",
  }
  resources :users, only: [:show]

  defaults format: :json do
    namespace :api do
      resources :posts
    end
  end
end
