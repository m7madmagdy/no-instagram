Rails.application.routes.draw do
  get "home/about"
  root "posts#index"

  resources :posts
  devise_for :users
  devise_scope :user do
    get "/users", to: "devise/registrations#new"
    get "/users/password", to: "devise/passwords#new"
    get "/users/sign_out", to: "devise/sessions#destroy"
  end

  defaults format: :json do
    namespace :api do
      resources :posts
    end
  end
end
