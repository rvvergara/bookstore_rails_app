Rails.application.routes.draw do
  namespace :v1, defaults: {format: :json } do
    resources :users, param: :username, only: [:create, :update, :show]
    resources :sessions, only: [:create]
    resources :categories, only: [:create, :update, :destroy]
  end
end
