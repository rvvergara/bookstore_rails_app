Rails.application.routes.draw do
  namespace :v1, defaults: {format: :json } do
    resources :users, param: :username, only: [:create, :update, :show, :index]
    resources :sessions, only: [:create]
    resources :categories, only: [:create, :update, :destroy]
    resources :books, only: [:index, :create]
  end
end
