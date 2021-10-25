Rails.application.routes.draw do
  devise_for :users
  root to: "experiences#index"
  resources :experiences, only: [:index]
  resources :users, only: [:show]
end
