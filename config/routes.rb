Rails.application.routes.draw do
  devise_for :users
  root to: "experiences#index"
  resources :experiences do
    resources :experience_comments, only: [:create, :edit, :update, :destroy]
    collection do
      get 'search_tag'
      get 'search_article'
    end
  end
  resources :users, only: [:show]
end
