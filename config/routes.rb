Rails.application.routes.draw do
  get 'home/about'
  root "posts#index"

  resources :posts
end
