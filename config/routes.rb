Rails.application.routes.draw do
  namespace :v1, defaults: {format: :json } do
    resources :users, only: [:create]
    resources :sessions, only: [:create]
  end
end
