Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }
  root to: "homes#index"
  resources :homes, only: [:index] do
    collection do
      get 'about'
    end
  end
  resources :experiences do
    resources :experience_comments, only: [:create, :edit, :update, :destroy]
    resources :experience_likes, only: [:create, :update]
    collection do
      get 'search_tag'
      get 'search_index'
    end
    member do
      get 'search_tag'
    end
  end
  resources :users, only: [:show]
end
